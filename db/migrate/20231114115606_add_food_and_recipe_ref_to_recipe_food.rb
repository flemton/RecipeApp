class AddFoodAndRecipeRefToRecipeFood < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipe_foods, :foods, null: false, foreign_key: true
    add_reference :recipe_foods, :recipe, null: false, foreign_key: true
  end
end
