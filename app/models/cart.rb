class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  # Campo para armazenar um token para carrinho de usuários não logados
  field :token, type: String

  def total
    cart_items.sum { |item| item.produto.preco * item.quantidade }
  end
end 