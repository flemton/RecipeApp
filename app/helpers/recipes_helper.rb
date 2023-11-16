module RecipesHelper
  def total_price(recipe_foods)
    total_price = 0

    recipe_foods.each do |recipe_food|
      food_price = recipe_food.food.price
      subtotal = food_price * recipe_food.quantity
      total_price += subtotal
    end

    total_price
  end
end
