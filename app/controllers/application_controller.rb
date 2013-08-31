class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :reset_session_on_missing_user, :require_authentication
  helper_method :current_user

  def require_authentication
    redirect_to login_path unless current_user
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def reset_session_on_missing_user
    if session[:user_id] && ! User.exists?(session[:user_id])
      reset_session
      redirect_to root_path
    end
  end
end
