class UserMailer < ApplicationMailer
  def register_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to RR Blog #{@user.username}")
  end
end
