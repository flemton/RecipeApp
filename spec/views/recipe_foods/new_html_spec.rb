require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Add Ingredient form', type: :system do
  describe 'New recipe form' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:food) do
      Food.create(user_id: user.id, name: 'banana', measurement_unit: 'kilos', price: 100, quantity: 45)
    end

    let!(:recipe) do
      Recipe.create(user_id: user.id, name: 'cafe', preparation_time: 1.5, cooking_time: 1, description: 'coffee',
                    public: 1)
    end

    before do
      sign_in user
      visit new_recipe_recipe_food_path(recipe)
    end

    it 'displays the heading' do
      expect(page).to have_css('h1', text: 'Add Ingredient')
    end

    it 'displays the food select field' do
      expect(page).to have_select('recipe_food_food_id', with_options: [food.name])
    end

    it 'displays the quantity field' do
      expect(page).to have_field('recipe_food_quantity')
    end

    it 'displays the submit button' do
      expect(page).to have_button('Add ingredient')
    end
  end
end
