require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  describe 'CATEGORY POST #create' do

    context 'invalid params' do
      before do
        post :create, params: {name: 'dd', slug: 'dd', resume: 'test'}
      end

      it 'should return error validation' do
        expect(response).to render_template(:new)
        expect(flash[:danger]).to match(/An error occurred when validating to your request.*/)
      end

      it 'should contain the error' do
        errors = flash[:errors]
        expect(errors).to include(:name)
      end
    end

    context 'invalid format params slug' do
      before do
        post :create, params: {name: 'Test de test', slug: 'Test de test', resume: 'test de test'}
      end

      it 'should return error validation' do
        expect(flash[:success]).to match(/Category was successfully created..*/)
        expect(response).to have_http_status(302)
      end

      it 'should return error contain slug' do
        category = Category.find(1)
        name = category[:name]
        slug = category[:slug]
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(slug).not_to eq(name)
      end

      it 'redirect create method' do
        category = Category.find(1)
        expect(response).to redirect_to(category)
      end
    end

    context 'valide create post method with slug empty' do
      before do
        post :create, params: {name: 'Test de test', slug: '', resume: 'test de test'}
      end

      it 'should return status 200' do
        expect(flash[:success]).to match(/Category was successfully created..*/)
        expect(response).to have_http_status(302)
      end

      it 'should return the contain category' do
        category = Category.find(1)
        expect(category.id).not_to be_nil
        expect(category.name).not_to be_nil
        expect(category.slug).not_to be_nil
        expect(category.resume).not_to be_nil
      end

      it 'should get slug empty attribute valide' do
        category = Category.find(1)
        name = category[:name]
        slug = category[:slug]
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(name.parameterize).to eq(slug)
      end

      it 'redirect create method' do
        category = Category.find(1)
        expect(response).to redirect_to(category)
      end
    end

    context 'valide create post method' do
      before do
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', resume: 'test de test'}
      end

      it 'should return status 200' do
        expect(flash[:success]).to match(/Category was successfully created..*/)
        expect(response).to have_http_status(302)
      end

      it 'should return the contain post' do
        category = Category.find(1)
        expect(category.id).not_to be_nil
        expect(category.name).not_to be_nil
        expect(category.slug).not_to be_nil
        expect(category.resume).not_to be_nil
      end

      it 'should get slug attribute valide' do
        category = Category.find(1)
        name = category[:name]
        slug = category[:slug]
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(name.parameterize).not_to eq (slug)
      end

      it 'should get date_cat is a datetime' do
        category = Category.find(1)
        date_cat = category['date_cat']
        expect(date_cat.to_time).not_to be_nil
      end

      it 'redirect create method' do
        category = Category.find(1)
        expect(response).to redirect_to(category)
      end
    end

  end

end