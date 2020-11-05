require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'POST #create' do

    context 'invalid params' do
      before do
        post :create, params: {name: 'dd', slug: 'dd', descr: 'test'}
      end

      it 'should return error validation' do
        expect(response).to have_http_status(422)
      end

      it 'should contain the error' do
        json = JSON.parse(response.body)
        expect(json).to include("name")
      end
    end

    context 'invalid format params slug' do
      before do
        post :create, params: {name: 'Test de test', slug: 'Test de test', descr: 'test de test'}
      end

      it 'should return error validation' do
        expect(response).to have_http_status(200)
      end

      it 'should return error contain slug' do
        data = JSON.parse(response.body)
        name = data['name']
        slug = data['slug']
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(slug).not_to eq(name)
      end
    end

    context 'valide create post method with slug empty' do
      before do
        post :create, params: {name: 'Test de test', slug: '', descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return the contain post' do
        json = JSON.parse(response.body)
        expect(json).to include("id")
        expect(json).to include("name")
        expect(json).to include("slug")
        expect(json).to include("descr")
        expect(json).to include("date_post")
      end

      it 'should get slug empty attribute valide' do
        data = JSON.parse(response.body)
        name = data['name']
        slug = data['slug']
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(name.parameterize).to eq(slug)
      end
    end

    context 'valide create post method' do
      before do
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return the contain post' do
        json = JSON.parse(response.body)
        expect(json).to include("id")
        expect(json).to include("name")
        expect(json).to include("slug")
        expect(json).to include("descr")
        expect(json).to include("date_post")
      end

      it 'should get slug attribute valide' do
        data = JSON.parse(response.body)
        name = data['name']
        slug = data['slug']
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(name.parameterize).not_to eq (slug)
      end

      it 'should get date_post is a datetime' do
        data = JSON.parse(response.body)
        date_post = data['date_post']
        expect(date_post.to_time).not_to be_nil
      end
    end

  end

end