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
      UserRegistrationEmailJob.perform_later(@user.id)
      @serialized_user = UserSerializer.new(@user)
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
