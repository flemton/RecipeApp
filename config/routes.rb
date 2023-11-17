Rails.application.routes.draw do
  devise_for :users
  resources :foods, only: [:index, :create, :new, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :recipe_foods, only: [:new, :create, :destroy, :update, :edit]
  end
  resources :general_shopping_list, only: [:index]
  get '/public_recipes', to: 'recipes#public_recipes'

  root 'foods#index'
end
