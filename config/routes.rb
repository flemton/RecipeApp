Rails.application.routes.draw do
  resources :foods, only: [:index, :create, :new, :destroy]
  resources :recipes, only: [:index, :show, :create, :new, :destroy]
  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]

  root 'foods#index'
end
