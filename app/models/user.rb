class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximum allowed' }
end
