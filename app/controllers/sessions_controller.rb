class SessionsController < ApplicationController
  def new
    @redirect = params[:redirect]
  end

  def create
    @redirect = params[:session][:redirect]
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Login successful'
      if !@redirect.blank?
        redirect_to @redirect
      else
        redirect_to articles_path
      end
    else
      flash.now[:alert] = 'Wrong login credentials'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logout successful'
    redirect_to root_path
  end
end
