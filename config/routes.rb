Rails.application.routes.draw do
  resources :authors
  resources :categories
  resources :sites
  resources :pages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
