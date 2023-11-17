class RecipeFood < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :quantity, presence: true

  def calculate_value_by_quantity
    quantity * food.price
  end
end
