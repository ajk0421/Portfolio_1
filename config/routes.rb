Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: "home#index"

  resources :users, only: :show

  resources :artists do
    member do
      get :gozyu_on
    end
    post :confirm, action: :confirm_new, on: :new
  end
end
