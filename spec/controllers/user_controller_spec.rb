require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #signin' do
    context 'should invalid params' do
      before do
        post :signin, params: {username: '', password: ''}
      end

      it 'should return error validation' do
        expect(response).to render_template(:login)
        expect(flash[:danger]).to match(/An error occurred when validating to your request.*/)
      end

      it 'should contain the error' do
        errors = flash[:errors]
        expect(errors).to include(:username)
        expect(errors).to include(:password)
      end
    end

    context 'should invalid response, if the field name is invalid' do
      before do
        @username = 'JohnDoe'
        @password = 'testpassword'

        post :signin, params: {username: @username, password: @password}
      end

      it 'should return error credentials' do
        expect(response).to render_template(:login)
        expect(flash[:danger]).to match(/An error occurred, yours credentials are incorrect.*/)
      end

      it 'should return method find_by_username falsey' do
        allow(User).to receive(:find_by_username).with(@username).and_return(false)
      end
    end

    context 'should invalid response, if the field password is invalid' do
      before do
        @user = build(:user)

        @username = 'JohnDoe1'
        @password = 'testdepassword'
        post :signin, params: {username: @username, password: @password}
      end

      it 'should return error credentials' do
        expect(response).to render_template(:login)
        expect(flash[:danger]).to match(/An error occurred, yours credentials are incorrect.*/)
      end

      it 'should return method find_by_username true' do
        allow(User).to receive(:find_by_username).with(@username).and_return(true)
      end

      it 'should return method password_check falsey' do
        allow(@user).to receive(:authenticate).with(@password).and_return(false)
      end
    end

    context 'should valid response with good credentials' do
      before do
        @username = 'JohnDoe'
        @password = 'motdepassedejohndoe'
        # Create user with the good password bcrypt
        @user = User.create({username: @username, password: @password, role: 0})

        post :signin, params: {username: @username, password: @password}
      end

      it 'should return success response' do
        expect(flash[:success]).to match(/You are connected.*/)
        expect(response).to redirect_to(root_url)
      end

      it 'should return method find_by_username true' do
        allow(User).to receive(:find_by_username).with(@username).and_return(true)
      end

      it 'should return method password_check falsey' do
        allow(@user).to receive(:authenticate).with(@password).and_return(true)
      end

      it 'should return session user' do
        expect(session[:user]).not_to be_nil
      end
    end
  end

end