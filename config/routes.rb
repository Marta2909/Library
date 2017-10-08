Rails.application.routes.draw do

  root "books#index"
  resources :books, only: [:index, :show]
  get "orderbook/:id", to: "books#orderbook", as: :orderbook
  get "returnbook/:id", to: "orders#returnbook", as: :returnbook

  namespace :admin do
    resources :books
  end

  #for Google auth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect("/")
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

  resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
