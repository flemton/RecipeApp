Rails.application.routes.draw do
  resources :foods
  resources :recipes
  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]
end
