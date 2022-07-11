class UserMailerJob
  include Sidekiq::Job

  def perform(user_id)
    @user = User.find(user_id)
    UserMailer.with(user: @user).register_email.deliver
  end
end
