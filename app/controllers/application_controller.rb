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
    end
  end

end
