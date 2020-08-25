class UserNotifierMailer < ApplicationMailer

  def inform_registration
    @user = params[:user]
    mail(to: @user.email, subject: "You have registered with Simple Sumo #{@user.username}!")
  end

end
