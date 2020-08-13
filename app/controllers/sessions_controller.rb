class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: session_params[:username])

    if @user && @user.authenticate(session_params[:password])
      login!
      @serialized_user = UserSerializer.new(@user)
      render json: { logged_in: true, user: @serialized_user }
    else
      render status: 200, json: {  errors: ['verify credentials and try again or sign up'] }
    end
  end
  
  def is_logged_in?
    if logged_in? && current_user
      serialized_user = UserSerializer.new(current_user)
      render json: { logged_in: true, user: serialized_user }
    else
      render json: { logged_in: false, message: 'no such user' }
    end
  end

  def destroy
    logout!
    render status: 200, json: { logged_out: true }
  end

  private

    def session_params
      params.require(:user).permit(:username, :password)
    end

end