require 'rails_helper'

RSpec.describe 'General Shopping List', type: :system do
  describe 'Shopping List page' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    before do
      sign_in user
      visit general_shopping_list_index_path
    end

    it 'displays the heading' do
      expect(page).to have_css('h1', text: 'General Shopping List')
    end

    it 'displays the amount of food items to buy' do
      expect(page).to have_content('Amount of food items to buy: 0')
    end

    it 'displays the total value of food needed' do
      expect(page).to have_content('Total value of food needed: 0$')
    end

    it 'displays the table headers' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
    end
  end
end