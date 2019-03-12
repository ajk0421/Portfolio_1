Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :users, only: :show

  resources :artists do
    post :confirm, action: :confirm_new, on: :new
  end
end
