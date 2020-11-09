require 'rails_helper'

RSpec.describe Api::SearchController, type: :controller do

  describe 'POST #search' do

    context 'error validation input search' do
      before do
        post :results, params: {q: ''}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return a message error to JSON' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq('The field search must be required.')
      end
    end

    context 'valid form search but any results' do
      before do
        post :results, params: {q: 'post'}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return message success' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_truthy
      end

      it 'should return results empty' do
        # Mocks
        allow(Post).to receive(:search).and_return(ActiveRecord::class)
        allow(Category).to receive(:search).and_return(ActiveRecord::class)

        json_response = JSON.parse(response.body)
        data = json_response['data']
        expect(data['posts'].count).to eq(0)
        expect(data['categories'].count).to eq(0)
      end
    end

    context 'valid form search only posts results' do
      before do
        FactoryBot.create_list(:post, 5)
        # Supplementary credentials for test
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description', :date_cat => Time.now})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description', :date_cat => Time.now})
        Post.create({:name => 'article de test', :slug => 'slug-de-test', :descr => 'description de test', :date_post => Time.now, :category_id => 'Anime,Manga'})

        post :results, params: {q: 'Post'}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return message success' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_truthy
      end

      it 'should return results only posts entity' do
        # Mocks
        allow(Post).to receive(:search).and_return(ActiveRecord::class)
        allow(Category).to receive(:search).and_return(ActiveRecord::class)

        json_response = JSON.parse(response.body)
        data = json_response['data']
        expect(data['posts'].count).to eq(5)
        expect(data['categories'].count).to eq(0)
      end
    end

    context 'valid form search only categories results' do
      before do
        FactoryBot.create_list(:category, 5)
        # Supplementary credentials for test
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description', :date_cat => Time.now})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description', :date_cat => Time.now})

        post :results, params: {q: 'Category'}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return message success' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_truthy
      end

      it 'should return results only category entity' do
        # Mocks
        allow(Post).to receive(:search).and_return(ActiveRecord::class)
        allow(Category).to receive(:search).and_return(ActiveRecord::class)

        json_response = JSON.parse(response.body)
        data = json_response['data']
        expect(data['posts'].count).to eq(0)
        expect(data['categories'].count).to eq(5)
      end
    end

    context 'valid form search for categories and posts results' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description', :date_cat => Time.now})
        Post.create({:name => 'One piece Manga', :slug => 'one-piece-manga', :descr => 'article de test', :date_post => Time.now, :category_id => 'Manga'})

        post :results, params: {q: 'Manga'}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return message success' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_truthy
      end

      it 'should return results category and posts entity' do
        # Mocks
        allow(Post).to receive(:search).and_return(ActiveRecord::class)
        allow(Category).to receive(:search).and_return(ActiveRecord::class)

        json_response = JSON.parse(response.body)
        data = json_response['data']
        expect(data['posts'].count).to eq(1)
        expect(data['categories'].count).to eq(1)
      end
    end

    context 'response success with q params don\'t equal to name to entity' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description', :date_cat => Time.now})
        Post.create({:name => 'One piece Manga', :slug => 'one-piece-manga', :descr => 'article de test', :date_post => Time.now, :category_id => 'Manga'})

        post :results, params: {q: 'Man'}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return message success' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_truthy
      end

      it 'should return results only category entity' do
        # Mocks
        allow(Post).to receive(:search).and_return(ActiveRecord::class)
        allow(Category).to receive(:search).and_return(ActiveRecord::class)

        json_response = JSON.parse(response.body)
        data = json_response['data']
        expect(data['posts'].count).to eq(1)
        expect(data['categories'].count).to eq(1)
      end
    end

    context 'response success with q params lowercase' do
      before do

        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description', :date_cat => Time.now})
        Post.create({:name => 'One piece Manga', :slug => 'one-piece-manga', :descr => 'article de test', :date_post => Time.now, :category_id => 'Manga'})

        post :results, params: {q: 'manga'}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return message success' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_truthy
      end

      it 'should return results only category entity' do
        # Mocks
        allow(Post).to receive(:search).and_return(ActiveRecord::class)
        allow(Category).to receive(:search).and_return(ActiveRecord::class)

        json_response = JSON.parse(response.body)
        data = json_response['data']
        expect(data['posts'].count).to eq(1)
        expect(data['categories'].count).to eq(1)
      end
    end
  end

end