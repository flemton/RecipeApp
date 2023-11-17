require 'rails_helper'

RSpec.describe 'Create a Recipe', type: :system do
  describe 'New recipe form' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    before do
      sign_in user
      visit new_recipe_path
    end
    it 'displays the heading' do
      expect(page).to have_css('h1', text: 'Create a Recipe')
    end
    it 'displays the name field' do
      expect(page).to have_field('recipe_name')
    end
    it 'displays the preparation time field' do
      expect(page).to have_field('recipe_preparation_time')
    end
    it 'displays the cooking time field' do
      expect(page).to have_field('recipe_cooking_time')
    end
    it 'displays the description field' do
      expect(page).to have_field('recipe_description')
    end
    it 'displays the public checkbox' do
      expect(page).to have_field('recipe_public')
    end
    it 'displays the submit button' do
      expect(page).to have_button('Create Recipe')
    end
    it 'displays the "Back to recipe" link' do
      expect(page).to have_link('Back to recipe', href: recipes_path)
    end
  end
end