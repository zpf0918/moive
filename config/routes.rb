Rails.application.routes.draw do
  resources :films
  root 'films#index'

end
