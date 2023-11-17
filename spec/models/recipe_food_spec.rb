require './spec/rails_helper'
RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'JD') }
  let(:food) { Food.create(name: 'Apple', measurement_unit: 'Piece', price: 1.99, quantity: 10) }
  let(:recipe) do
    Recipe.create(name: 'Apple Pie', preparation_time: 30, cooking_time: 60, description: 'Delicious apple pie recipe',
                  user_id: user, public: true)
  end
  subject { RecipeFood.new(food:, recipe:, quantity: 2) }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end
    it 'should have the quantity present' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
  end
  context 'Associations' do
    it 'should belong to a food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'should belong to a recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  describe 'calculate_value_by_quantity' do
    it 'returns the calculated value based on the quantity and food price' do
      expect(subject.calculate_value_by_quantity).to eq(3.98)
    end
  end
end