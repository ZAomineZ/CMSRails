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

    context 'should invalid response, if the field username is invalid' do
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

  describe 'PUT #update_account to user' do
    context 'error validation to user entity' do
      before do
        # Create a user for the test
        User.create(username: 'JohnDoe', password: 'johndoemotdepasse')
        
        put :update_account, params: {user_id: 1, username: '', password: '', password_confirmation: ''}
      end

      it 'should return error response' do
        expect(response).to render_template(:account)
        expect(flash[:danger]).to match(/An error occurred, yours credentials are invalid.*/)
      end

      it 'should contain errors to user entity' do
        errors = flash[:errors]
        expect(errors).to include(:username)
        expect(errors).to include(:password)
      end
    end

    context 'should invalid response, if user don\'t exist' do
      before do
        # Create a user for the test
        User.create(username: 'JohnDoe', password: 'johndoemotdepasse')

        @username = 'JohnDoe5'
        @password = 'testpassword'
        @password_confirmation = 'testpassword'
        put :update_account, params: {user_id: 55, username: @username, password: @password, password_confirmation: @password_confirmation}
      end

      it 'should return error credentials' do
        expect(response).to render_template(:account)
        expect(flash[:danger]).to match(/An error occurred, yours credentials are incorrect.*/)
      end

      it 'should return method find_by_username falsey' do
        allow(User).to receive(:find_by_username).with(@username).and_return(false)
      end
    end

    context 'should invalid response, if field password and field password_confirmation aren\'t identical' do
      before do
        # Create a user for the test
        User.create(username: 'JohnDoe', password: 'johndoemotdepasse')

        @username = 'JohnDoe5'
        @password = 'testpassword'
        @password_confirmation = 'testpassword1'
        put :update_account, params: {user_id: 1, username: @username, password: @password, password_confirmation: @password_confirmation}
      end

      it 'should return error credentials' do
        expect(response).to render_template(:account)
        expect(flash[:danger]).to match(/An error occurred, yours credentials are invalid.*/)
      end

      it 'should contain errors to user entity' do
        errors = flash[:errors]
        expect(errors).to include(:password)
        expect(errors[:password][0]).to eq("Yours passwords aren't the same ")
      end

      it 'should don\'t update user' do
        @user = User.find(1)
        expect(@user.username).to eq('JohnDoe')
      end
    end

    context 'valid response good params and user exist' do
      before do
        # Create a user for the test
        User.create(username: 'JohnDoe', password: 'johndoemotdepasse')

        @username = 'JohnDoe5'
        @password = 'testpassword'
        @password_confirmation = 'testpassword'
        put :update_account, params: {user_id: 1, username: @username, password: @password, password_confirmation: @password_confirmation}
      end

      it 'should return response success credentials' do
        expect(response).to redirect_to(account_path)
        expect(flash[:success]).to match(/You have edited your credentials.*/)
        expect(session[:user]).to be_truthy
      end

      it 'should update user' do
        @user = User.find(1)
        compare_password = BCrypt::Password.new(@user.password_digest) == @password
        expect(@user.username).to eq('JohnDoe5')
        expect(compare_password).to be_truthy
      end
    end
  end
end