class UserRegistrationEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    UserNotifierMailer.with(user: user).inform_registration.deliver_later
  end
  
end