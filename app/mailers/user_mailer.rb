class UserMailer < ApplicationMailer
  default_from: 'testemail@simplesumo.com'

  def welcome_email
    @user = params[:user]
    @url = "http://localhost:3000/verify/#{@user.id}"
    mail(to: @user.email, subject: 'Welcome to Simple Sumo')
  end

end
´