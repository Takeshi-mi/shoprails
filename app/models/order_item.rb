class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order
  belongs_to :produto

  field :quantidade, type: Integer
  field :preco_unitario, type: Float

  validates :quantidade, presence: true, numericality: { greater_than: 0 }
  validates :preco_unitario, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def subtotal
    quantidade * preco_unitario
  end
end 