class PagamentosController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @pedidos = Order.all
  end

  def create
    require 'mercadopago'
    sdk = Mercadopago::SDK.new('TEST-8120324154956106-021217-676a0055762b74af4f1ae99a531a4e42-561811876')
  
    payment_data = {
      transaction_amount: params[:transaction_amount].to_f,
      token: params[:token],
      description: params[:description],
      installments: params[:installments].to_i,
      payment_method_id: params[:payment_method_id],
      payer: {
        email: params[:payer][:email],
        identification: {
          type: params[:payer][:identification][:type],
          number: params[:payer][:identification][:number]
        },
        first_name: params[:cardholderName]
      }
    }
  
    payment_response = sdk.payment.create(payment_data)
    puts "Resposta Completa: #{payment_response.inspect}"
  
    if payment_response[:response]
      status = payment_response[:response]['status']
      case status
      when 'approved'
        # Save the order in the database
        order = current_user.orders.create!(
          pagamento_id: payment_response[:response]['id'],
          total: payment_data[:transaction_amount],
          status: 'approved'
        )
        current_user.cart.destroy
        render json: { success: true, redirect_url: pagamento_sucesso_path, notice: "Pagamento aprovado! Pedido salvo com ID: #{current_user.order.pagamento_id}" }
      when 'in_process'
        render json: { success: true, redirect_url: pagamento_processando_path, notice: "Pagamento em processamento." }
      when 'rejected'
        render json: { success: false, redirect_url: pagamento_erro_path, notice: "Pagamento rejeitado." }, status: :unprocessable_entity
      else
        render json: { success: false, error: "Status desconhecido: #{status}" }, status: :unprocessable_entity
      end
    else
      render json: { success: false, error: "Resposta inválida" }, status: :unprocessable_entity
    end
  end

  private
    def set_pedido
      @pedido = Order.find(params[:id])
    end

    def pedido_params
      params.fetch(:pedido, {})
    end
    def salvar_pedido
      pedidos_array = params[:pedidos]
      Order.create!(pedidos: pedidos_array)
      redirect_to products_path, notice: "Pedido salvo com sucesso!"
    end
end

