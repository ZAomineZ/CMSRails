class UsersController < ApplicationController

  before_action :only_signed_out, only: [:signin, :login]
  before_action :only_signed_in, only: [:account, :update_account, :logout]
  before_action :admin_access, only: [:account, :update_account, :logout]

  def login
  end

  def signin
    # Check validation to user entity
    user_entity = User.new(params_user)
    unless user_entity.valid?
      flash.now[:danger] = 'An error occurred when validating to your request.'
      flash.now[:errors] = user_entity.errors.messages
      return render action: 'login'
    end

    @user = User.find_by_username(params[:username])
    # Check credentials to user
    password = params[:password]
    if @user && !@user.empty? && user_entity.authenticate(password) && user_entity.valid_password(password, @user[0])
      session[:user] = @user[0]
      flash[:success] = "You are connected."
      redirect_to root_url
    else
      flash[:danger] = 'An error occurred, yours credentials are incorrect.'
      render action: 'login'
    end
  end

  def account
    @user = session[:user] ? session[:user] : nil
    @flash_success = flash[:success]
    @flash_danger = flash[:danger]
    @errors = flash[:errors]
  end

  def update_account
    # Find user to relation with the cretendials
    @user = User.exists?(params[:user_id])
    unless @user
      flash[:danger] = 'An error occurred, yours credentials are incorrect.'
      return render action: 'account'
    end
    # Check validation to user entity
    user_validation = AccountValidator.new(params_user_account)
    unless params_user_account.permitted?
      flash[:danger] = 'An error occurred, yours credentials are invalid.'
      flash[:errors] = user_validation.errors.messages
      return redirect_to account_path
    end
    # Update the credentials to user entit
    @user_entity = User.find(params[:user_id])
    request_valid = params[:password].length != 0 && params[:password_confirmation].length != 0 ? @user_entity.update(params_user) : @user_entity.update_attribute(:username, params[:username])
    if request_valid
      session[:user] = @user_entity
      flash[:success] = "You have edited your credentials."
      redirect_to account_path
    end
  end

  def logout
    session[:user] = nil
    response = {
        success: true,
        message: 'You are logout.'
    }
    render json: response
  end

  private

  def params_user(credentials_accept = true)
    if credentials_accept
      params.permit(:username, :password)
    else
      params.permit(:username)
    end
  end

  def params_user_account
    if params[:password].length != 0 && params[:password_confirmation].length != 0
      params.permit(:username, :password, :password_confirmation)
    else
      params.permit(:username)
    end
  end

end
