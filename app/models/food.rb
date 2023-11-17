class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximum allowed' }
  validates :measurement_unit, presence: true,
                               length: { maximum: 50, too_long: '%<count>s characters is the maximum allowed' }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true
end
