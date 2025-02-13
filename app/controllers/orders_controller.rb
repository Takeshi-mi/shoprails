class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    cart = current_cart
    
    if cart.cart_items.empty?
      redirect_to cart_path, alert: 'Seu carrinho está vazio!'
      return
    end

    @order = Order.create_from_cart(cart, current_user)

    if @order
      cart.destroy # Limpa o carrinho após criar o pedido
      redirect_to @order, notice: 'Pedido criado com sucesso!'
    else
      redirect_to cart_path, alert: 'Erro ao criar pedido.'
    end
  end

  private

  def current_cart
    Cart.find_or_create_by(user: current_user)
  end
end 