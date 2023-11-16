class RecipeFoodsController < ApplicationController
  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_back_or_to root_path, notice: 'The recipe food was successfully removed.'
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def new
    @recipe_food = RecipeFood.new
    @foods = current_user.foods
  end

  def create
    @recipe_food = RecipeFood.new(recipe_id: params[:recipe_id], **recipe_food_params)

    if @recipe_food.save
      flash[:notice] = 'Recipe food created successfully added'
      redirect_to recipe_path(params[:recipe_id])
    else
      flash.now[:error] = 'Failed to create the post.'
      render :new
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(update_recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe_id), notice: 'The recipe food was successfully updated.'
    else
      flash[:alert] = 'Failed to update recipe food'
      redirect_back_or_to root_path
    end
  end

  private

  def update_recipe_food_params
    params.require(:recipe_food).permit(:quantity)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
