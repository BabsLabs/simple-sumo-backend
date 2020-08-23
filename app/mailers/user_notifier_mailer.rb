class UserNotifierMailer < ApplicationMailer

    def inform_registration(info, recipient)
        @user = info[:user]
        mail(to: recipient, subject: "You have registered with Simple Sumo #{@user.username}!")
    end

end
