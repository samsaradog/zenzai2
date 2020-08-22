Rails.application.routes.draw do
  devise_for :users, controllers: {:registrations => "users/registrations"}
  resources :users, only: :index
  resources :jewels

  get "pages/home"
  get "pages/about"
  get "pages/support"
  get "pages/zenzai"

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
