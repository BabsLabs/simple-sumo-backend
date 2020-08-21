class UserEmailJob < ApplicationJob
  queue_as :default

  def perform(email)

  end
end
