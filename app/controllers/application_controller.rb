class ApplicationController < ActionController::Base
  # session helper methods which are available to all views
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def validate_session
    if !logged_in?
      redirect_to login_path
      flash[:alert] = 'Please log in to keep browsing!'
    end
  end
end
