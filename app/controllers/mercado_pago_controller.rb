class MercadoPagoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  
  def webhook
    # TODO: Implementar processamento do webhook do Mercado Pago
    # 1. Verificar a autenticidade do webhook
    # 2. Buscar o pedido usando o external_reference
    # 3. Atualizar o status do pedido
    
    if params[:type] == "payment"
      payment_id = params[:data][:id]
      
      # Aqui você buscará as informações do pagamento na API do Mercado Pago
      # payment_info = MercadoPago::Payment.find(payment_id)
      # order = Order.find_by(mercado_pago_external_reference: payment_info.external_reference)
      
      # if order
      #   order.process_payment(payment_info)
      # end
    end
    
    head :ok
  end
  
  def success
    # TODO: Implementar página de sucesso
    # O usuário será redirecionado para cá após um pagamento bem-sucedido
    @order = current_user.orders.find_by(id: params[:order_id])
    redirect_to order_path(@order), notice: "Pagamento realizado com sucesso!"
  end
  
  def pending
    # TODO: Implementar página de pendente
    # O usuário será redirecionado para cá se o pagamento estiver pendente
    @order = current_user.orders.find_by(id: params[:order_id])
    redirect_to order_path(@order), notice: "Pagamento em processamento. Você receberá uma confirmação em breve."
  end
  
  def failure
    # TODO: Implementar página de falha
    # O usuário será redirecionado para cá se houver alguma falha no pagamento
    @order = current_user.orders.find_by(id: params[:order_id])
    redirect_to order_path(@order), alert: "Houve um problema com o pagamento. Por favor, tente novamente."
  end
end
