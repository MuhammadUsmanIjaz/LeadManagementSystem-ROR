Rails.application.routes.draw do
  
  resources :leads do
    get '/comments', to: 'comments#showleadcomments'
    match "/comments", to: "comments#createleadcomment", via: [:post]
    resources :phases do
      get '/comments', to: 'comments#showphasecomments'
      match "/comments", to: "comments#createphasecomment", via: [:post]
      member do
        get 'addengineers'
        match "respond", to: "phases#respond", via: [:get]
        match "respond", to: "phases#saveresponse", via: [:post]
        match "respond", to: "phases#addcomments", via: [:put]
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
  match 'projects', to: 'projects#addmanagers', via: [:post]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
