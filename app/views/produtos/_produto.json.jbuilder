json.extract! produto, :id, :name, :preco, :descricao, :created_at, :updated_at
json.url produto_url(produto, format: :json)
