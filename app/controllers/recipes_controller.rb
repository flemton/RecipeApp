class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(update_public_recipe_params)
      flash[:notice] = 'This recipe public state has been updated'
    else
      flash[:alert] = 'Failed to update the public state of this recipe'
    end
    redirect_to @recipe
  end

  def new
    @recipe = Recipe.new
    @user = current_user
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
      else
        flash.now[:alert] = 'The arguments are invalid.'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def public_recipes
    @public_recipes = Recipe.includes(:recipe_foods, recipe_foods: :food).where(public: true).order(created_at: :asc)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
    end
  end

  private

  def update_public_recipe_params
    params.require(:recipe).permit(:public)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
