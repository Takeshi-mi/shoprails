class CartItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :cart
  belongs_to :produto

  field :quantidade, type: Integer, default: 1

  validates :quantidade, presence: true, numericality: { greater_than: 0 }
end 