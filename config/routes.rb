Rails.application.routes.draw do
  devise_for :users
  resources :films do
    member do
      post :join
      post :quit
    end


    resources :posts
  end
  root 'films#index'


namespace :account do
  resources :films
end
end
