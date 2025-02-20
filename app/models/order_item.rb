class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :order
  belongs_to :produto

  field :quantidade, type: Integer, default: 1
  field :preco_unitario, type: Float

  # Calcula o subtotal do item
  def subtotal
    quantidade * preco_unitario
  end
end