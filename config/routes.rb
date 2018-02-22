Rails.application.routes.draw do

  root 'books#index'
  resources :books, only: [:index, :show]
  get 'search_results', to: 'books#search_results', as: :search_results
  get 'orderbook/:id', to: 'books#orderbook', as: :orderbook
  get 'returnbook/:id', to: 'orders#returnbook', as: :returnbook

  namespace :admin do
    get 'user_statistics', to: 'users#statistics', as: :user_statistics
    resources :books
  end

  #for Google auth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect("/")
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create]

  resources :orders, only: [:index, :create]

  get 'log_out_admin', to: 'application#log_out_admin', as: :log_out_admin


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
