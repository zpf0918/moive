Rails.application.routes.draw do
  devise_for :users
  resources :films do
    resources :posts
  end
  root 'films#index'

end
