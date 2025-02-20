IMAGENS = [
  "https://www.ruby-toolbox.com/assets/images/logos/pry-0b8b8b8b8b8b8b8b8b8b8b8b8b8b8b8b8.png", # Pry
  "https://camo.githubusercontent.com/a57d325456368a7f0a3a22a2a6b97ad9496d3b6b9b12b0b7f1bf9cd966007286/68747470733a2f2f7777772e64726f70626f782e636f6d2f732f7a70386f36336b7175627932726c6e2f7072795f6c6f676f5f3335302e706e673f7261773d31", # Pry-Doc
  "https://camo.githubusercontent.com/a57d325456368a7f0a3a22a2a6b97ad9496d3b6b9b12b0b7f1bf9cd966007286/68747470733a2f2f7777772e64726f70626f782e636f6d2f732f7a70386f36336b7175627932726c6e2f7072795f6c6f676f5f3335302e706e673f7261773d31", # Pry-Nav
  "https://camo.githubusercontent.com/a57d325456368a7f0a3a22a2a6b97ad9496d3b6b9b12b0b7f1bf9cd966007286/68747470733a2f2f7777772e64726f70626f782e636f6d2f732f7a70386f36336b7175627932726c6e2f7072795f6c6f676f5f3335302e706e673f7261773d31", # Pry-Rails
  "https://camo.githubusercontent.com/a57d325456368a7f0a3a22a2a6b97ad9496d3b6b9b12b0b7f1bf9cd966007286/68747470733a2f2f7777772e64726f70626f782e636f6d2f732f7a70386f36336b7175627932726c6e2f7072795f6c6f676f5f3335302e706e673f7261773d31", # Pry-Theme
  "https://miro.medium.com/v2/resize:fit:698/1*GByJx-gKYjcey2pG1PUZ7g.jpeg", # Capybara
  "https://images.seeklogo.com/logo-png/34/2/mercado-pago-logo-png_seeklogo-342347.png", # MercadoPago SDK
  "https://sass-lang.com/assets/img/logos/logo-b6e1ef6e.svg", # Sassc-Rails
  "https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo-shadow.png", # Bootstrap
  "https://minds.digital/wp-content/uploads/2023/06/autenticacao-segura.png", # Devise
  "https://sitechecker.pro/wp-content/uploads/2017/12/pagination.png", # Kaminari
  "https://sitechecker.pro/wp-content/uploads/2017/12/pagination.png" # Kaminari-Mongoid
]

gemas = [
  { name: "Pry", descricao: "Uma alternativa poderosa ao IRB, com navegação por métodos e inspeção de objetos." },
  { name: "Pry-Doc", descricao: "Extensão do Pry que fornece acesso à documentação oficial do Ruby e do Rails." },
  { name: "Pry-Nav", descricao: "Adiciona suporte a comandos de navegação passo a passo no Pry." },
  { name: "Pry-Rails", descricao: "Integra o Pry ao Rails, substituindo o console padrão." },
  { name: "Pry-Theme", descricao: "Permite personalizar o tema visual do Pry." },
  { name: "Capybara", descricao: "Ferramenta para testes de sistema que simula interações de usuário em navegadores." },
  { name: "MercadoPago SDK", descricao: "SDK oficial do Mercado Pago para integração de pagamentos online." },
  { name: "Sassc-Rails", descricao: "Integra o compilador SassC ao Rails para uso de SCSS." },
  { name: "Bootstrap", descricao: "Framework front-end para desenvolvimento de interfaces responsivas." },
  { name: "Devise", descricao: "Solução completa para autenticação de usuários em aplicações Rails." },
  { name: "Kaminari", descricao: "Gem para paginação de resultados em consultas ao banco de dados." },
  { name: "Kaminari-Mongoid", descricao: "Extensão do Kaminari para trabalhar com o ORM Mongoid." }
]

gemas.each_with_index do |gema, index|
  Produto.create!(
    name: gema[:name],
    preco: 10.00 + index * 2,
    descricao: gema[:descricao],
    foto: IMAGENS[index]
  )
end

puts "Gemas adicionadas com sucesso!"