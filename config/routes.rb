Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations", 
    passwords: "users/passwords", 
    registrations: "users/registrations", 
    sessions: "users/sessions",
    unlocks: "users/unlocks",
  }
  resources :users, only: :index
  resources :jewels

  get "pages/home"
  get "pages/about"
  get "pages/support"
  get "pages/zenzai"

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
