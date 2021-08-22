Rails.application.routes.draw do
  
  resources :leads do
    resources :phases do
      member do
        get 'addengineers'
        match 'addengineers', to: 'phases#add', via: [:post]
        match 'addengineers', to: 'phases#delengineer', via: [:delete]
      end
    end
  end


  devise_for :users
  get 'home/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'

  get "/projects", to: "projects#index"
  get "/projects/new", to: "projects#create"
  match 'project', to: 'projects#destroy', via: [:delete]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
