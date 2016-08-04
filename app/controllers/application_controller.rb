require 'BCrypt'

class ApplicationController < ActionController::Base
  before_action :check_user

  protected

  def check_user
    if session[:user_password] and session[:user_id]
      user = User.find(session[:user_id])

      if user.password == session[:user_password]
        @saved_user = user
        @saved_user_ability = Ability.new(user)
      else
        session.delete(:user_id)
        session.delete(:user_password)
      end
    elsif params[:user_token] != nil
      token = UserToken.find_by({:token => params[:user_token], :is_valid => true})

      if token != nil
        @saved_user = token.user
        @saved_user_ability = Ability.new(@saved_user)
      else

      end
    end
  end

end
