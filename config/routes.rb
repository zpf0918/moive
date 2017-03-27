Rails.application.routes.draw do
  resources :films
  root 'welcome#index'
  
end
