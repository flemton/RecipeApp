require 'rails_helper'
RSpec.describe 'Public Recipes', type: :system do
  describe 'Public recipes page' do
    let(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:recipe) do
      Recipe.create(user_id: user.id, name: 'cafe', preparation_time: 1.5, cooking_time: 1, description: 'coffee',
                    public: 1)
    end

    before do
      user.confirm
      sign_in user
      visit public_recipes_path
    end

    it 'displays the heading' do
      expect(page).to have_css('h1', text: 'Public Recipes')
    end

    it 'displays recipe details' do
      expect(page).to have_css('h3 a', text: 'cafe')
      expect(page).to have_content('by JD')
      expect(page).to have_content('Total food items: 0')
      expect(page).to have_content('Total price: $0')
      expect(page).to have_link('See Recipe', href: recipe_path(recipe))
    end
  end
end
