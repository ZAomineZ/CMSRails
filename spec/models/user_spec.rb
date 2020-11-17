require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    context 'Field validation error username' do
      it 'should invalidate username is not required' do
        user = build(:user_username_dont_presence)
        user.validate
        expect(user.errors.messages).to include(:username)
        expect(user.valid?).to be false
      end

      it 'should invalidate username length to minimum 5 characters' do
        user = build(:user_username_minimum)
        user.validate
        expect(user.errors.messages).to include(:username)
        expect(user.valid?).to be false
      end

      it 'should invalidate username length to maximum 60 characters' do
        user = build(:user_username_maximum)
        user.validate
        expect(user.errors.messages).to include(:username)
        expect(user.valid?).to be false
      end

      it 'should invalidate username with format invalid' do
        user = build(:user_username_format)
        user.validate
        expect(user.errors.messages).to include(:username)
        expect(user.valid?).to be false
      end
    end

    context 'Field validation error password' do
      it 'should invalidate password is not required' do
        user = build(:user_password_dont_presence)
        user.validate
        expect(user.errors.messages).to include(:password)
        expect(user.valid?).to be false
      end

      it 'should invalidate password length to minimum 5 characters' do
        user = build(:user_password_minimum)
        user.validate
        expect(user.errors.messages).to include(:password)
        expect(user.valid?).to be false
      end

      it 'should invalidate password length to maximum 60 characters' do
        user = build(:user_password_maximum)
        user.validate
        expect(user.errors.messages).to include(:password)
        expect(user.valid?).to be false
      end
    end
  end
end
