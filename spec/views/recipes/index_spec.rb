require 'rails_helper'

RSpec.describe 'Recipe/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:recipe1) do
      Recipe.create(user_id: user.id, name: 'cafe', preparation_time: 1.5, cooking_time: 1, description: 'coffee',
                    public: 1)
    end

    let!(:recipe2) do
      Recipe.create(user_id: user.id, name: 'marron', preparation_time: 1.5, cooking_time: 2,
                    description: 'Hello world', public: 1)
    end

    before do
      sign_in user
      visit recipes_path
    end

    it 'displays a list of foods' do
      expect(page).to have_content('Recipes')

      expect(page).to have_content(recipe1.name)
      expect(page).to have_content(recipe2.name)
      expect(page).to have_content(recipe2.description)
      expect(page).to have_content(recipe1.description)
    end

    it 'Display button remove' do
      expect(page).to have_button('Remove')
      expect(page).to have_link('Show this recipe')
    end

    it 'Check correct url' do
      expect(page).to have_link('New recipe', href: new_recipe_path)
    end
  end
end
