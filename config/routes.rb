Rails.application.routes.draw do
  resources :foods, only: [:index, :create, :new, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :recipe_foods, only: [:new, :create, :destroy, :update, :edit]
  end
  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]

  root 'foods#index'
end
