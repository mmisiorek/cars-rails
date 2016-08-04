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

      respond_to do |format|
        format.html do
          session[:user_password] = @user.password
          session[:user_id] = @user.id
          redirect_to "/"
        end

        format.json do
          token = UserToken.new
          token.is_valid = true
          token.save

          user_json = @user.as_json
          user_json[:token] = token.token

          render :json => {
                     :success => true,
                     :user => user_json
                 }
        end
      end
    else
      respond_to do |format|
        format.html do
          redirect_to :action => 'sign_in'
        end

        format.json do
          render :json => {
                     :success => false
                 }
        end
      end
    end
  end

  def logout
    respond_to do |format|
      format.html do
        session.delete(:user_password)
        session.delete(:user_id)

        redirect_to request.referer
      end

      format.json do
        userToken = UserToken.find_by({token: logout_json_params[:user_token], is_valid: true})

        if userToken != nil
          userToken.is_valid = false
          userToken.save

          render :json => {
                     :success => true
                 }
        else
          render :json => {
                     :success => false
                 }
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def logout_json_params
    params.permit(:user_token)
  end

end
