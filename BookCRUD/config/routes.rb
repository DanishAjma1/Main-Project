Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "books#index"
  resources :books do
  resources :reviews, only: [ :create, :edit, :update, :destroy ]
  end
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
