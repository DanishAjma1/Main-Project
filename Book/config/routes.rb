Rails.application.routes.draw do 
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
}
namespace :api do
    namespace :v1 do 
      resources :books
      devise_for :users, controllers: {
        sessions: "api/v1/sessions",
        registrations: "api/v1/registrations"
      }

      resources :books, only: [ :index, :show, :create, :update, :destroy ]
    end
  end
  root "books#index"
  resources :books do
  resources :reviews, only: [ :create, :edit, :update, :destroy ]
  end
end
