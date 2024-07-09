Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  resources :offers, only: [:index, :destroy]
  resources :movies do
    resources :offers, only: [:show, :new, :create, :update]
  end
end
