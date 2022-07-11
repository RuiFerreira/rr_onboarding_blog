class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserMailer.with(user: user).register_email.deliver
  end
end
