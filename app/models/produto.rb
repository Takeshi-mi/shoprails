class Produto
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :preco, type: Integer
  field :descricao, type: String
  field :foto, type: String
end
