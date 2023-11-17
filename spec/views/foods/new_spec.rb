require 'rails_helper'

RSpec.describe 'Foods/new.html', type: :system do
  describe 'New food form' do
    let!(:user) do
      User.create(name: 'JD', email: 'jdx@gmail.com', password: 'password', password_confirmation: 'password')
    end

    before do
      sign_in user
      visit new_food_path
    end

    it 'displays the New Food form' do
      expect(page).to have_content('New food')
      expect(page).to have_selector('form', count: 1)
    end

    it 'allows user to create a new food' do
      fill_in 'Name', with: 'Example Food'
      select 'Kilograms', from: 'Measurement unit'
      fill_in 'Price', with: '10.99'
      fill_in 'Quantity', with: '5'

      click_button 'Create Food'

      expect(page).to have_content('Food was successfully created.')
      expect(page).to have_content('Example Food')
    end

    it 'displays validation errors if form is submitted with invalid data' do
      click_button 'Create Food'

      expect(page).to have_content('The arguments are invalid.')
    end

    it 'allows the user to navigate back to the foods index' do
      click_link 'Back to foods'

      expect(page).to have_selector('h1', text: 'Foods')
    end
  end
end