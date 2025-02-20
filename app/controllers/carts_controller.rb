class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_item
    @cart = current_cart
    produto = Produto.find(params[:produto_id])
    quantidade = params[:quantidade].to_i || 1

    cart_item = @cart.cart_items.find_or_initialize_by(produto: produto)
    cart_item.quantidade += quantidade
    
    if cart_item.save
      flash[:notice] =  'Produto adicionado ao carrinho!'
      redirect_to home_path
    else
      redirect_to root_path, alert: 'Erro ao adicionar produto ao carrinho.'
    end
  end

  def remove_item
    @cart = current_cart
    cart_item = @cart.cart_items.find(params[:item_id])
    cart_item.destroy

    redirect_to cart_path, notice: 'Produto removido do carrinho!'
  end

  private

  def current_cart
    if user_signed_in?
      Cart.find_or_create_by(user: current_user)
    else
      Cart.find_or_create_by(token: session[:cart_token]) do |cart|
        session[:cart_token] ||= SecureRandom.hex(8) # Gera um novo token se não existir de 8 bytes hexadeciaml
        cart.token = session[:cart_token] 
      end
    end
  end
end 