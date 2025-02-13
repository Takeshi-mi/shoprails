class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :order_items, dependent: :destroy

  field :total, type: Float
  field :status, type: String, default: 'aguardando' # aguardando, pago, cancelado

  validates :user, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  # Status possíveis
  STATUS = {
    'aguardando' => 'Aguardando Pagamento',
    'pago' => 'Pago',
    'cancelado' => 'Cancelado'
  }

  # Retorna o status formatado para exibição
  def status_formatado
    STATUS[status] || status
  end

  def self.create_from_cart(cart, user)
    return nil if cart.cart_items.empty?

    order = Order.new(user: user)
    total = 0

    cart.cart_items.each do |item|
      order_item = order.order_items.build(
        produto: item.produto,
        quantidade: item.quantidade,
        preco_unitario: item.produto.preco
      )
      total += order_item.preco_unitario * order_item.quantidade
    end

    order.total = total
    order.save ? order : nil
  end
end 