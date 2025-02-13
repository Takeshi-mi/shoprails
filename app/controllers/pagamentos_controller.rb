class PagamentosController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
 
  def index
  end

  def create
    require 'mercadopago'
    # sdk = Mercadopago::SDK.new(ENV['MERCADO_PAGO_ACCESS_TOKEN'])
    sdk = Mercadopago::SDK.new('TEST-8120324154956106-021217-676a0055762b74af4f1ae99a531a4e42-561811876')
    binding.pry
    payment_data = {
      transaction_amount: params[:transaction_amount].to_f,
      token: params[:token],
      description: params[:description],
      installments: params[:installments].to_i,
      payment_method_id: params[:paymentMethodId],
      payer: {
        email: [:payer][:email],
        identification: {
          type: [:payer][:identification][:type],
          number: [:payer][:identification][:number]
        },
        first_name: params[:cardholderName]
      }
    }
    if
    begin
      payment_response = sdk.payment.create(payment_data)
      payment = payment_response[:response]

      if payment['status'] == 'approved'
        # Criar pedido no banco de dados
        order = current_user.orders.create!(
          status: 'paid',
          payment_id: payment['id'],
          total_amount: payment_data[:transaction_amount]
        )
        
        # Limpar o carrinho após o pagamento bem sucedido
        session[:cart] = nil
        
        flash[:success] = 'Pagamento realizado com sucesso!'
        redirect_to order_path(order)
      else
        flash[:error] = 'Erro no processamento do pagamento. Por favor, tente novamente.'
        redirect_to cart_path
      end
    rescue => e
      flash[:error] = 'Ocorreu um erro no processamento do pagamento. Por favor, tente novamente.'
      Rails.logger.error("Erro no pagamento: #{e.message}")
      redirect_to cart_path
    end
  end
end
