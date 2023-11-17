require 'rails_helper'

RSpec.describe 'Foods/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:food1) do
      Food.create(user_id: user.id, name: 'banana', measurement_unit: 'kilos', price: 100, quantity: 45)
    end

    let!(:food2) do
      Food.create(user_id: user.id, name: 'grapes', measurement_unit: 'kilos', price: 10, quantity: 5)
    end

    before do
      sign_in user
      visit foods_path
    end

    it 'displays a list of foods' do
      expect(page).to have_content('Foods')

      expect(page).to have_content(food1.name)
      expect(page).to have_content(food2.name)
    end

    it 'Display button remove' do
      expect(page).to have_button('Remove')
    end

    it 'Check correct url' do
      expect(page).to have_link('New food', href: new_food_path)
    end
  end
end
