class ApplicationController < ActionController::Base

  private

  def only_signed_in
    unless current_user
      redirect_to login_path, danger: "Vous n'avez pas le droit d'accéder à cette page !"
    end
  end

  def only_signed_out
    redirect_to admin_page_path if current_user
  end

  def current_user
    user_session = session[:user]
    user_session && get_user(user_session)
  end

  def get_user(user_session)
    User.find(user_session[0] ? user_session[0]['id'] : nil)
  end

  def admin_access
    redirect_to root_path, danger: "Vous n'avez pas le droit d'accéder à cette page !" if current_user && get_user(session[:user]).role != true
  end

end
