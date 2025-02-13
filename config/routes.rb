Rails.application.routes.draw do
  # Define a rota raiz para a página inicial
  root "home#index"
  
  # Rotas do Devise para autenticação
  devise_for :users
  
  resources :produtos do
    member do
      post 'add_to_cart'
    end
  end
  
  # Rotas do carrinho
  resource :cart, only: [:show] do
    post 'add_item/:produto_id', to: 'carts#add_item', as: :add_item
    delete 'remove_item/:item_id', to: 'carts#remove_item', as: :remove_item
    delete 'remove_item'
  end

  # Rotas de pedidos
  resources :orders, only: [:index, :show, :create]

  # Rotas do Mercado Pago
  post '/mercado_pago/webhook', to: 'mercado_pago#webhook'
  get '/mercado_pago/success', to: 'mercado_pago#success'
  get '/mercado_pago/pending', to: 'mercado_pago#pending'
  get '/mercado_pago/failure', to: 'mercado_pago#failure'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
