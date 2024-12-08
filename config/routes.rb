# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_for :admins
  get "welcome/index"

  get "/inicio", to: "welcome#index"

  namespace :administrate do
    resources :pagamentos
    resources :reservas
    resources :clientes
    resources :carros do
      member do
        delete "destroy_cover_image"
      end
    end

    resources :categorias
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "welcome#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
