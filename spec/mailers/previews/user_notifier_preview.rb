# Preview all emails at http://localhost:3001/rails/mailers/user_notifier
class UserNotifierPreview < ActionMailer::Preview
  def inform_registration_preview
    user = User.new(username: 'userName', email: 'email@testemail.com', password: 'testPassword', password_confirmation: 'testPassword')
    email_info = { user: user }
    UserNotifierMailer.inform_registration(email_info)
  end
end
