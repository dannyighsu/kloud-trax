Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "pages#index"

  match "/signup", to: "users#create", via: 'get'
  match "/auth/:provider/callback", to: "sessions#create", via: 'get'
  match "/signout", to: "sessions#destroy", via: 'get'
  match "/about", to: "pages#about", via: 'get'
  match "/help", to: "pages#help", via: 'get'
  match "/player", to: "player#player", via: 'get'
  match "/add", to: "accounts#create", via: 'get'
  match "/accounts/update", to: "accounts#update", via: 'post'
  match "/update", to: "users#populate", via: 'get'
  match "/to_preferences", to: "player#to_preferences", via: 'get'

  resources :users
  resources :tracks
  resources :accounts
end
