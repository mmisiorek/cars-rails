require 'bcrypt'

class User < ActiveRecord::Base
  before_save :password_encode

  has_many :documents
  has_many :cars

  def as_json(options={})
    h = super(options)
    h = h.except("password", "salt", "updated_at")

    h
  end

  private

  def password_encode
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(self.password, self.salt)
  end
end
