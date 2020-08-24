class UserNotifierMailer < ApplicationMailer

  def inform_registration(info)
    @user = info[:user]
    mail(to: @user.email, subject: "You have registered with Simple Sumo #{@user.username}!")
  end

end
