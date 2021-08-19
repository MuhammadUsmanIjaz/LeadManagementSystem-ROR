Rails.application.routes.draw do
  resources :leads
  devise_for :users
  get 'home/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
