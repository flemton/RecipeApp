require './spec/rails_helper'
RSpec.describe 'recipes/show', type: :system do
  describe 'Show page' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:recipe) do
      Recipe.create(user_id: user.id, name: 'cafe', preparation_time: 1.5, cooking_time: 1, description: 'coffee',
                    public: 1)
    end

    before do
      sign_in user
      visit recipe_path(recipe)
    end
    it 'displays the recipe name' do
      expect(page).to have_css('h1', text: 'cafe')
    end
    it 'displays the preparation time' do
      expect(page).to have_content('Preparation time: 1.5 hours')
    end
    it 'displays the cooking time' do
      expect(page).to have_content('Cooking time: 1.0 hours')
    end
    it 'displays the recipe description' do
      expect(page).to have_content('coffee')
    end
    it 'displays the "Generate Shopping List" button for authorized users' do
      expect(page).to have_link('Generate Shopping List')
    end
    it 'displays the "Add Ingredient" button for authorized users' do
      expect(page).to have_link('Add Ingredient', href: new_recipe_recipe_food_path(recipe))
    end
    it 'displays the table headers' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Measurement Unit')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Value')
      expect(page).to have_content('Actions')
    end
    it 'renders the recipe foods in the table' do
      recipe.recipe_foods.each do |recipe_food|
        expect(page).to have_content(recipe_food.food)
        expect(page).to have_content(recipe_food.measurement_unit)
        expect(page).to have_content(recipe_food.quantity)
        expect(page).to have_content(recipe_food.value)
      end
    end
  end
end
