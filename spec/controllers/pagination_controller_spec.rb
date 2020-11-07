require 'rails_helper'

RSpec.describe Api::PaginationController, type: :controller do

  describe 'POST #set_pagination_posts' do

    context 'pagination posts error page bigger to pages' do
      before do
        FactoryBot.create_list(:post, 20)
        post :set_pagination_posts, params: {page: 3}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return success false with message error' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq('This page don\'t exist for this entity.')
      end
    end

    context 'pagination posts error page smaller to pages' do
      before do
        FactoryBot.create_list(:post, 20)
        post :set_pagination_posts, params: {page: 0}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return success false with message error' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq('This page don\'t exist for this entity.')
      end
    end

    context 'pagination posts success' do
      before do
        FactoryBot.create_list(:post, 20)
        post :set_pagination_posts, params: {page: 2}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return success false with message error' do
        json_response = JSON.parse(response.body)
        data = json_response['data']

        expect(json_response['success']).to be_truthy
        expect(data['page']).to eq(2)
        expect(data['items'].count).to eq(10)
        expect(data['items'][0]['id']).to eq(11)
        expect(data['current_page']).to eq(2)
      end
    end

  end

  describe 'POST #set_pagination_categories' do

    context 'pagination categories error page bigger to pages' do
      before do
        FactoryBot.create_list(:category, 20)
        post :set_pagination_categories, params: {page: 3}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return success false with message error' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq('This page don\'t exist for this entity.')
      end
    end

    context 'pagination categories error page smaller to pages' do
      before do
        FactoryBot.create_list(:category, 20)
        post :set_pagination_categories, params: {page: 0}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return success false with message error' do
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq('This page don\'t exist for this entity.')
      end
    end

    context 'pagination categories success' do
      before do
        FactoryBot.create_list(:category, 20)
        post :set_pagination_categories, params: {page: 2}
      end

      it 'should return response 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should return success false with message error' do
        json_response = JSON.parse(response.body)
        data = json_response['data']

        expect(json_response['success']).to be_truthy
        expect(data['page']).to eq(2)
        expect(data['items'].count).to eq(10)
        expect(data['items'][0]['id']).to eq(11)
        expect(data['current_page']).to eq(2)
      end
    end

  end

end