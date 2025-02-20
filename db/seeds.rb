# Produto.destroy_all

IMAGENS = [
  "https://raw.githubusercontent.com/ruby/www.ruby-lang.org/master/images/header-ruby-logo.png",
  "https://cdn-icons-png.flaticon.com/256/10112/10112502.png"
]

DESCRIÇÕES = [
  "O pior produto da empresa",
  "O produto mais barato da empresa",
  "O produto mais cheiroso da empresa",
  "O produto mais rápido da empresa",
  "O produto mais lento da empresa"
]
8.times do |i|
  Produto.create!(
    # name: "Produto #{i}",
    name: "Produto Ruby",
    preco: 10.00 + i*2,
    descricao: DESCRIÇÕES[i % DESCRIÇÕES.length],
    foto: IMAGENS[i % 2]
  )
end
Produto.create!(
  name: "Produto especial",
  preco: 100000,
  descricao: "2 REAIS OU UM PRESENTE MISTERIOSO?",
  foto: "https://www.foldaboxusa.com/cdn/shop/products/32156_Ruby_on_Red_A5_Deep_2000x.jpg?v=1625250703"
)

puts "Produtos criados com sucesso!"

User.create!(
  email: 'teste@teste',
  password: '123456'
)

puts "Usuário criado com sucesso!"


