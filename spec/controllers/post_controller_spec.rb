require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'POST #create' do

    context 'invalid params' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        post :create, params: {name: 'dd', slug: 'dd', categories: 'Manga,Anime', descr: 'test'}
      end

      it 'should return error validation' do
        expect(response).to have_http_status(200)
      end

      it 'should contain the error' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('An error occurred when validating to your request.')
        expect(data['errorFields']).to include('name')
        expect(data['errorFields']).to include('descr')
      end
    end

    context 'invalid format params slug' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        post :create, params: {name: 'Test de test', slug: 'Test de test', categories: 'Manga,Anime', descr: 'test de test'}
      end

      it 'should return error validation' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return error contain slug' do
        post = Post.find(1)
        name = post[:name]
        slug = post[:slug]
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(slug).not_to eq(name)
      end
    end

    context 'valide create post method with slug empty' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        post :create, params: {name: 'Test de test', slug: '', categories: 'Manga,Anime', descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return the contain post' do
        post = Post.find(1)
        expect(post.id).not_to be_nil
        expect(post.name).not_to be_nil
        expect(post.slug).not_to be_nil
        expect(post.descr).not_to be_nil
        expect(post.date_post).not_to be_nil
      end

      it 'should get slug empty attribute valide' do
        post = Post.find(1)
        name = post['name']
        slug = post['slug']
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(name.parameterize).to eq(slug)
      end
    end

    context 'valide create post method' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga,Anime', descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return the contain post' do
        post = Post.find(1)
        expect(post.id).not_to be_nil
        expect(post.name).not_to be_nil
        expect(post.slug).not_to be_nil
        expect(post.descr).not_to be_nil
        expect(post.date_post).not_to be_nil
      end

      it 'should get slug attribute valide' do
        post = Post.find(1)
        name = post['name']
        slug = post['slug']
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(name.parameterize).not_to eq (slug)
      end

      it 'should get date_post is a datetime' do
        post = Post.find(1)
        date_post = post['date_post']
        expect(date_post.to_time).not_to be_nil
      end
    end

    context 'valide create post method with many categories' do
      before do
        categories = 'Manga,Anime'
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return attributes categories' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:dontExist).and_return(false)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga,Anime')
        expect(categories).to include(',')
      end

    end

    context 'valide create post method with a category' do
      before do
        categories = 'Manga'
        Category.create({:name => categories, :slug => 'manga', :resume => 'test de description'})
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return attributes categories' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:dontExist).and_return(false)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga')
        expect(categories).not_to include(',')
      end
    end

    context 'invalid categories dont exist for method create post' do
      before do
        categories = 'Manga'
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('One of the selected categories don\'t exist.')
      end

      it 'should don\'t return attributes categories' do
        # Mocks
        allow(Category).to receive(:dontExist).and_return(true)

        count = Post.count
        expect(count).to eq(0)
      end
    end

    context 'invalid categories empty dont exist for method create post' do
      before do
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: '', descr: 'test de test'}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('One category must be selected.')
      end

      it 'should don\'t return attributes categories' do
        count = Post.count
        expect(count).to eq(0)
      end
    end
  end

end