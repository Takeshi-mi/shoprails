Produto.destroy_all

IMAGENS = [
  "https://raw.githubusercontent.com/ruby/www.ruby-lang.org/master/images/header-ruby-logo.png",
  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/1200px-Ruby_logo.svg.png"
]

10.times do |i|
  Produto.create!(
    name: "Produto #{i}",
    preco: 10.00 + i*2,
    descricao: "Descrição do produto #{i}",
    foto: IMAGENS[i % 2]
  )
end

puts "Produtos criados com sucesso!"
