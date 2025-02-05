require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do

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

        post :create, params: {name: 'Test de test', slug: 'Test de test', categories: 'Manga,Anime', descr: 'test de test', image: nil }
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

    context 'valid create post method with slug empty' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})

        post :create, params: {name: 'Test de test', slug: '', categories: 'Manga,Anime', descr: 'test de test', image: nil}
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

    context 'valid create post method' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})

        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga,Anime', descr: 'test de test', image: nil}
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

    context 'valid create post method with many category' do
      before do
        categories = 'Manga,Anime'
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})

        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return attributes category' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:dontExist).and_return(false)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga,Anime')
        expect(categories).to include(',')
      end

    end

    context 'valid create post method with a category' do
      before do
        categories = 'Manga'
        Category.create({:name => categories, :slug => 'manga', :resume => 'test de description'})

        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return attributes category' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:dontExist).and_return(false)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga')
        expect(categories).not_to include(',')
      end
    end

    context 'invalid create post with identical category for one post' do
      before do
        categories = 'Manga,Manga'
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})

        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('You are add one same category, we are delete the duplicate category.')
      end

      it 'should return attributes category with the data uniq category' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:check_idem).and_return(true)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga')
        expect(categories).not_to include(',')
      end
    end

    context 'invalid category dont exist for method create post' do
      before do
        categories = 'Manga'
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('One of the selected category don\'t exist.')
      end

      it 'should don\'t return attributes category' do
        # Mocks
        allow(Category).to receive(:dontExist).and_return(true)

        count = Post.count
        expect(count).to eq(0)
      end
    end

    context 'invalid category empty dont exist for method create post' do
      before do
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: '', descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('One category must be selected.')
      end

      it 'should don\'t return attributes category' do
        count = Post.count
        expect(count).to eq(0)
      end
    end

    context 'valid create post with file valid' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})

        file = Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/images/rails.png'))
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga', descr: 'test de test', image: file}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response success true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return post with image' do
        post = Post.find(1)
        expect(post['img_original']).to eq('rails.png')
        expect(post['img_medium']).to eq('medium_rails.png')
        expect(post['img_thumb']).to eq('thumb_rails.png')
        expect(post['img_mini']).to eq('mini_rails.png')
      end
    end

    context 'valid create post with file invalid' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})

        file = nil
        post :create, params: {name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga', descr: 'test de test', image: file}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response success true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully created.')
      end

      it 'should return post with image' do
        post = Post.find(1)

        expect(post['img_original']).to be_nil
        expect(post['img_medium']).to eq('medium_image.png')
        expect(post['img_thumb']).to eq('thumb_image.png')
        expect(post['img_mini']).to eq('mini_image.png')
      end

      it 'should return good dimensions for the custom files' do
        file_original_custom = File.join(Rails.root, '/public/images/default/image.png')
        file_medium_custom = File.join(Rails.root, '/public/images/default/medium_image.png')
        file_thumb_custom = File.join(Rails.root, '/public/images/default/thumb_image.png')
        file_mini_custom = File.join(Rails.root, '/public/images/default/mini_image.png')

        expect(File.exist?(file_original_custom)).to be_truthy
        expect(File.exist?(file_medium_custom)).to be_truthy
        expect(File.exist?(file_thumb_custom)).to be_truthy
        expect(File.exist?(file_mini_custom)).to be_truthy
      end
    end
  end

  describe 'PUT #update' do

    context 'invalid params' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        Category.create({:name => 'Série', :slug => 'serie', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'dd', slug: 'dd', categories: 'Manga,Anime,Série', descr: 'test'}
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

      it 'should dont update the post' do
        post = Post.find(1)
        expect(post.name).not_to eq('dd')
        expect(post.slug).not_to eq('dd')
        expect(post.category_id).not_to eq('Manga,Anime,Série')
        expect(post.descr).not_to eq('test')
      end
    end

    context 'invalid format params slug' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        Category.create({:name => 'Série', :slug => 'serie', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: 'Test de test', categories: 'Manga,Anime,Série', descr: 'test de test', image: nil}
      end

      it 'should return error validation' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully edited.')
      end

      it 'should return error contain slug' do
        post = Post.find(1)
        name = post[:name]
        slug = post[:slug]
        expect(slug).to match(/[a-z][a-z\-]*[a-z]/)
        expect(slug).not_to eq(name)
      end

      it 'should update credentials to post' do
        post = Post.find(1)
        expect(post.name).to eq('Test de test')
        expect(post.slug).to eq('test-de-test')
        expect(post.category_id).to eq('Manga,Anime,Série')
        expect(post.descr).to eq('test de test')
      end
    end

    context 'valide update post method with slug empty' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        Category.create({:name => 'Série', :slug => 'serie', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: '', categories: 'Manga,Anime,Série', descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully edited.')
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

      it 'should update credentials to post' do
        post = Post.find(1)
        expect(post.name).to eq('Test de test')
        expect(post.slug).to eq('test-de-test')
        expect(post.category_id).to eq('Manga,Anime,Série')
        expect(post.descr).to eq('test de test')
      end
    end

    context 'valide update post method' do
      before do
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        Category.create({:name => 'Série', :slug => 'serie', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga,Anime,Série', descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully edited.')
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

      it 'should update credentials to post' do
        post = Post.find(1)
        expect(post.name).to eq('Test de test')
        expect(post.slug).to eq('test-de-test-de-test')
        expect(post.category_id).to eq('Manga,Anime,Série')
        expect(post.descr).to eq('test de test')
      end
    end

    context 'valide update post method with category' do
      before do
        categories = 'Manga,Anime,Série'
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})
        Category.create({:name => 'Série', :slug => 'serie', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully edited.')
      end

      it 'should return attributes category' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:dontExist).and_return(false)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga,Anime,Série')
        expect(categories).to include(',')
      end

      it 'should update credentials to post' do
        post = Post.find(1)
        expect(post.name).to eq('Test de test')
        expect(post.slug).to eq('test-de-test-de-test')
        expect(post.category_id).to eq('Manga,Anime,Série')
        expect(post.descr).to eq('test de test')
      end

    end

    context 'invalid category dont exist for method update post' do
      before do
        categories = 'One piece'
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})
        Category.create({:name => 'Anime', :slug => 'anime', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('One of the selected category don\'t exist.')
      end

      it 'should don\'t return attributes category' do
        # Mocks
        allow(Category).to receive(:dontExist).and_return(true)

        count = Post.count
        expect(count).to eq(1)
      end

      it 'should dont update the post' do
        post = Post.find(1)
        expect(post.name).not_to eq('Test de test')
        expect(post.slug).not_to eq('test-de-test-de-test')
        expect(post.category_id).not_to eq('One piece')
        expect(post.name).not_to eq('test de test')
      end
    end

    context 'invalid category empty dont exist for method create post' do
      before do
        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: '', descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_falsey
        expect(data['message']).to eq('One category must be selected.')
      end

      it 'should dont update the post' do
        post = Post.find(1)
        expect(post.name).not_to eq('Test de test')
        expect(post.slug).not_to eq('test-de-test-de-test')
        expect(post.category_id).not_to eq('')
        expect(post.name).not_to eq('test de test')
      end
    end

    context 'invalid create post with identical category for one post' do
      before do
        categories = 'Manga,Manga'
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})

        post = create(:post_categories)
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: categories, descr: 'test de test', image: nil}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response false' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('You are add one same category, we are delete the duplicate category.')
      end

      it 'should return attributes category with the data uniq category' do
        post = Post.find(1)
        categories = post.category_id

        # Mocks
        allow(Category).to receive(:check_idem).and_return(true)

        expect(categories).not_to be_nil
        expect(categories).to eq('Manga')
        expect(categories).not_to include(',')
      end
    end

    context 'valid update post with file' do
      before do
        post = create(:post_categories)
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})

        file = Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/images/ruby-logo.png'))
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga', descr: 'test de test', image: file}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response success true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully edited.')
      end

      it 'should return post with image' do
        post = Post.find(1)
        expect(post['img_original']).to eq('ruby-logo.png')
        expect(post['img_medium']).to eq('medium_ruby-logo.png')
        expect(post['img_thumb']).to eq('thumb_ruby-logo.png')
        expect(post['img_mini']).to eq('mini_ruby-logo.png')
      end
    end

    context 'valid create post with file invalid' do
      before do
        post = create(:post_categories)
        Category.create({:name => 'Manga', :slug => 'manga', :resume => 'test de description'})

        file = nil
        put :update, params: {id: post.id, name: 'Test de test', slug: 'test-de-test-de-test', categories: 'Manga', descr: 'test de test', image: file}
      end

      it 'should return status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return response success true' do
        data = JSON.parse(response.body)
        expect(data['success']).to be_truthy
        expect(data['message']).to eq('Post was successfully edited.')
      end

      it 'should return post with image' do
        post = Post.find(1)

        expect(post['img_original']).to be_nil
        expect(post['img_medium']).to eq('medium_image.png')
        expect(post['img_thumb']).to eq('thumb_image.png')
        expect(post['img_mini']).to eq('mini_image.png')
      end

      it 'should return good dimensions for the custom files' do
        file_original_custom = File.join(Rails.root, '/public/images/default/image.png')
        file_medium_custom = File.join(Rails.root, '/public/images/default/medium_image.png')
        file_thumb_custom = File.join(Rails.root, '/public/images/default/thumb_image.png')
        file_mini_custom = File.join(Rails.root, '/public/images/default/mini_image.png')

        expect(File.exist?(file_original_custom)).to be_truthy
        expect(File.exist?(file_medium_custom)).to be_truthy
        expect(File.exist?(file_thumb_custom)).to be_truthy
        expect(File.exist?(file_mini_custom)).to be_truthy
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'error request action delete' do
      before do
        create(:post_categories)
        delete :destroy, params: {id: 5}
      end

      it 'should return error when post dont exist' do
        expect(flash[:danger]).to match(/An error occurred when delete your post.*/)
      end

      it 'redirect destroy method' do
        expect(response).to redirect_to(admin_posts_path)
      end

      it 'error occurred delete category' do
        count = Post.count
        expect(count).to eq(1)
      end
    end

    context 'success method destroy' do
      before do
        cat = create(:post_categories)
        delete :destroy, params: {id: cat.id}
      end

      it 'should return a message flash success' do
        expect(flash[:success]).to match(/Post was successfully deleted.*/)
      end

      it 'redirect destroy method' do
        expect(response).to redirect_to(admin_posts_path)
      end

      it 'error occurred delete post' do
        count = Post.count
        expect(count).to eq(0)
      end
    end

    context 'success method destroy with file exist' do
      before do
        # Create a new entity post
        post = create(:post_categories)
        delete :destroy, params: {id: post.id}
      end

      it 'should return a message flash success' do
        expect(flash[:success]).to match(/Post was successfully deleted.*/)
      end

      it 'redirect destroy method' do
        expect(response).to redirect_to(admin_posts_path)
      end

      it 'error occurred delete category' do
        count = Category.count
        expect(count).to eq(0)
      end

      it 'should remove path directory to image' do
        directory = PathHelper.path_dir_public('category', 1)
        path = File.exist?(directory)
        expect(path).to be_falsey
      end
    end
  end

end