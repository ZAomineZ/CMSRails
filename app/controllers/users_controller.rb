class UsersController < ApplicationController

  before_action :only_signed_out, only: [:signin, :login]
  before_action :only_signed_in, only: [:account, :update_account, :logout]

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
      session[:user] = @user
      flash[:success] = "You are connected."
      redirect_to root_url
    else
      flash[:danger] = 'An error occurred, yours credentials are incorrect.'
      render action: 'login'
    end
  end

  def account
    @user = session[:user] ? session[:user][0] : nil
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
    params_accept = params[:password].length != 0 && params[:password_confirmation].length != 0
    if User.find(params[:user_id]).update(params_user(params_accept))
      session[:user] = User.find(params[:user_id])
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
      params.require(:user).permit(:username, :password)
    else
      params.require(:user).permit(:username)
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
