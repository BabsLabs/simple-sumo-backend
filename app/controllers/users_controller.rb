class UsersController < ApplicationController

  def show
    begin
      user = User.find(params[:id])
      if user
        serialized_user = UserSerializer.new(user)
        render json: { user: serialized_user }
      else
        render  status: 404, json: { errors: ['user not found'] }
      end
    rescue ActiveRecord::RecordNotFound  
      render  status: 404, json: { errors: ['user not found'] }
      return
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      login!
      UserRegistrationEmailJob.perform_later(@user.id)
      serialized_user = UserSerializer.new(@user)
      render status: 201, json: { user: serialized_user }
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user && !user.email_confirmed
      user.verify_user
      redirect_to("http://babslabs-simple-sumo.herokuapp.com/login?verified=successful")
    elsif user && user.email_confirmed
      redirect_to("http://babslabs-simple-sumo.herokuapp.com/login?verified=already_verified")
    end
  end

  def email_activate
    self.email_confirmed = true
    save!(:validate => false)
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
