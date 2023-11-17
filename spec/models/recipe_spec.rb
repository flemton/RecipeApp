# spec/models/recipe_spec.rb
require './spec/rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'JD') }
  subject do
    Recipe.new(name: 'Delicious Recipe', user:, preparation_time: 30, cooking_time: 45, description: 'A tasty recipe')
  end

  context 'Validation' do
    it 'should have the name present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have a maximum length of 250 characters with a custom error message' do
      subject.name = 'a' * 251
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include('250 characters is the maximum allowed')
    end

    it 'should have the preparation time present' do
      subject.preparation_time = nil
      expect(subject).to_not be_valid
    end

    it 'should have a non-negative preparation time' do
      subject.preparation_time = -5
      expect(subject).to_not be_valid
    end

    it 'should have the cooking time present' do
      subject.cooking_time = nil
      expect(subject).to_not be_valid
    end

    it 'should have a non-negative cooking time' do
      subject.cooking_time = -10
      expect(subject).to_not be_valid
    end

    it 'should have the description present' do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  end
end