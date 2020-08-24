class UserRegistrationEmailJob < ApplicationJob
  queue_as :default

  def perform(email_info)
    UserNotifierMailer.inform_registration(email_info).deliver_later
  end
  
end