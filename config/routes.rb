Rails.application.routes.draw do
  resources :contacts
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'root#index'
end
