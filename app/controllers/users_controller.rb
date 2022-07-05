class UsersController < ApplicationController
  before_action :set_user, only: %I[show edit update destroy]
  def show; end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.username}, you are now a member of Runtime Revolution's Blog!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Profile edited successfully'
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      # TODO: end session here when implemented
      flash[:notice] = 'User successfully deleted'
      redirect_to root_path
    else
      flash[:alert] = 'User could not be deleted'
      redirect_to 'show'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end

end
