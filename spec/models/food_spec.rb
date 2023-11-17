require './spec/rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'JD') }
  subject { Food.new(name: 'Apple', measurement_unit: 'Piece', price: 1.99, quantity: 10, user:) }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end
    it 'should have the name present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'should have a maximum name length of 250 characters' do
      subject.name = 'x' * 251
      expect(subject).to_not be_valid
    end
    it 'should have the measurement unit present' do
      subject.measurement_unit = nil
      expect(subject).to_not be_valid
    end
    it 'should have a maximum measurement unit length of 50 characters' do
      subject.measurement_unit = 'x' * 51
      expect(subject).to_not be_valid
    end
    it 'should have the price present and greater than or equal to 0' do
      subject.price = nil
      expect(subject).to_not be_valid
      subject.price = -1
      expect(subject).to_not be_valid
    end
    it 'should have the quantity present' do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
  end
  context 'Associations' do
    it 'should belong to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'should have many recipe_foods' do
      association = described_class.reflect_on_association(:recipe_foods)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end