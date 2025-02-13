class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :order_items, dependent: :destroy

  field :total, type: Float
  field :status, type: String, default: 'aguardando' # aguardando, pago, cancelado
  
  # Campos para Mercado Pago
  field :mercado_pago_id, type: String
  field :mercado_pago_status, type: String
  field :mercado_pago_payment_type, type: String
  field :mercado_pago_payment_method, type: String
  field :mercado_pago_external_reference, type: String

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

  # Métodos para Mercado Pago
  def paid?
    status == 'pago'
  end

  def can_pay?
    status == 'aguardando'
  end

  def payment_url
    # TODO: Implementar integração com Mercado Pago
    # Retornará a URL de pagamento do Mercado Pago
    '#'
  end

  def process_payment(payment_data)
    # TODO: Implementar processamento do pagamento
    # Será chamado quando recebermos o webhook do Mercado Pago
    if payment_data[:status] == 'approved'
      update(status: 'pago',
             mercado_pago_status: payment_data[:status],
             mercado_pago_payment_type: payment_data[:payment_type],
             mercado_pago_payment_method: payment_data[:payment_method])
    end
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