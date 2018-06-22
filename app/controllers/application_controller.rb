class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :require_login
  protect_from_forgery with: :exception
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
  def require_login
    unless current_user
      flash[:errors] = ["You must be logged in to access this section"]
      redirect_to "/"
    end
  end
end
