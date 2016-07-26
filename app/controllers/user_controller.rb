require 'BCrypt'

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

    if @user.valid?
      @user.save

      respond_to do |format|
        format.html do
          render :template => 'user/registered'
        end
      end
    end
  end

  def sign_in
    if not @user
      @pageTitle = "Sign in"
      @user = User.new
    else
      redirect_to '/'
    end
  end

  def login
    @user = User.find_by(:username => user_params[:username])

    if @user.password == BCrypt::Engine.hash_secret(user_params[:password], @user.salt)
      session[:user_password] = @user.password
      session[:user_id] = @user.id

      redirect_to "/"
    else
      redirect_to :action => 'sign_in'
    end
  end

  def logout
    session.delete(:user_password)
    session.delete(:user_id)

    redirect_to request.referer
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
