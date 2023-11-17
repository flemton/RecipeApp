class GeneralShoppingListController < ApplicationController
  def index
    @recipes_foods = current_user.recipes.joins(:recipe_foods).select('recipe_foods.*')
    @user_foods = current_user.foods
  end
end
