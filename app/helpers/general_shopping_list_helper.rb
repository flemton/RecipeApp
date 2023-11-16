module GeneralShoppingListHelper
  def generate_missing_foods(user_foods, recipe_foods)
    user_recipe_foods = recipe_foods.group_by(&:food_id).transform_values { |foods| foods.sum(&:quantity) }

    missing_foods = []

    user_recipe_foods.each do |food_id, recipe_food_quantity|
      user_food = user_foods.find_by(id: food_id)
      next unless user_food && user_food.quantity < recipe_food_quantity

      missing_foods << {
        food: user_food,
        quantity_remaining: recipe_food_quantity - user_food.quantity,
        price_remaining: user_food.price * (recipe_food_quantity - user_food.quantity)
      }
    end

    missing_foods
  end

  def total_price_remaining(missing_foods)
    total_price = 0
    missing_foods.each do |missing_food|
      total_price += missing_food[:price_remaining]
    end
    total_price
  end
end
