class User < ActiveRecord::Base
  before_save :password_encode

  private

  def password_encode
    @salt = BCrypt::Engine.generate_salt
    @password = BCrypt::Engine.hash_secret(@password, @salt)
  end
end
