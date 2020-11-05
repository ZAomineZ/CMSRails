require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'validation' do
    describe 'Field validation error name' do
      it 'should validate name is not required' do
        post = build(:post_invalid_name_presence)
        post.validate
        expect(post.errors.messages).to include(:name)
        expect(post.valid?).to be false
      end

      it 'should validate name length to minimum 5 characters' do
        post = build(:post_invalid_name_minimun)
        post.validate
        expect(post.errors.messages).to include(:name)
        expect(post.valid?).to be false
      end

      it 'should validate name length to maximum 60 characters' do
        post = build(:post_invalid_name_maximum)
        post.validate
        expect(post.errors.messages).to include(:name)
        expect(post.valid?).to be false
      end
    end

    describe 'Field validation error descr' do
      it 'should validate descr is not required' do
        post = build(:post_invalid_descr_presence)
        post.validate
        expect(post.errors.messages).to include(:descr)
        expect(post.valid?).to be false
      end

      it 'should validate descr length to minimum 10 characters' do
        post = build(:post_invalid_descr_minimum)
        post.validate
        expect(post.errors.messages).to include(:descr)
        expect(post.valid?).to be false
      end
    end
  end

end
