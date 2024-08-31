Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "books#index"
  resources :books do
    resources :reviews
  end
end
