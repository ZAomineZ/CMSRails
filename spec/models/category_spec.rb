require 'rails_helper'

RSpec.describe Category, type: :model do

  context 'validation' do
    describe 'Field validation error name' do
      it 'should validate name is not required' do
        category = build(:category_invalid_name_presence)
        category.validate
        expect(category.errors.messages).to include(:name)
        expect(category.valid?).to be false
      end

      it 'should validate name is too short' do
        category = build(:category_invalid_name_minimum)
        category.validate
        expect(category.errors.messages).to include(:name)
        expect(category.valid?).to be false
      end

      it 'should validate name is too large' do
        category = build(:category_invalid_name_maximum)
        category.validate
        expect(category.errors.messages).to include(:name)
        expect(category.valid?).to be false
      end
    end

    describe 'Field validation error resume' do
      it 'should validate resume is not required' do
        category = build(:category_invalid_resume_presence)
        category.validate
        expect(category.errors.messages).to include(:resume)
        expect(category.valid?).to be false
      end

      it 'should validate resume is not required' do
        category = build(:category_invalid_resume_minimum)
        category.validate
        expect(category.errors.messages).to include(:resume)
        expect(category.valid?).to be false
      end
    end
  end

end
