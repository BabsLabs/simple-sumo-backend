class UsersController < ApplicationController

  def show
    begin
      @user = User.find(params[:id])
      if @user
        @serialized_user = UserSerializer.new(@user)
        render json: { user: @serialized_user }
      else
        render  status: 404, json: { errors: ['user not found'] }
      end
    rescue ActiveRecord::RecordNotFound  
      render  status: 404, json: { errors: ['user not found'] }
      return
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      @serialized_user = UserSerializer.new(@user)
       # `recipient` is the email address that should be receiving the message
      recipient = @user.email
      # `email_info` is the information that we want to include in the email message.
      email_info = { user: @user
                 }
      UserNotifierMailer.inform_registration(email_info, recipient).deliver_now
 
      render status: 201, json: { user: @serialized_user }
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
