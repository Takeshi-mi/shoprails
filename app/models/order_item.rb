class OrderItem
  include Mongoid::Document

  belongs_to :order
  belongs_to :produto

  field :quantidade, type: Integer
  field :preco_unitario, type: Float

  validates :quantidade, numericality: { greater_than: 0 }
  validates :preco_unitario, numericality: { greater_than_or_equal_to: 0 }
end