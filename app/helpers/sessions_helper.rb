module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user?(user_id)
    user_id == current_user.id
  end

  def admin_user?
    "あり" == current_user.admin
  end

end