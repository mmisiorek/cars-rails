class UserController < ApplicationController

  def sign_up
    @pageTitle = "Sign up"
    @user = User.new
  end

  def create
    if params[:user][:password] != params[:user][:repeat_password]
      redirect_to action: 'sign_up'
      return
    end

    @user = User.new(user_params)

    abort params.inspect
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
