class UserToken < ActiveRecord::Base
  before_create :add_random_token

  belongs_to :user

  private

  def add_random_token
    token = ""

    loop do
      token = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

      break if UserToken.find_by({:token => token}) == nil
    end

    self.token = token
  end
end
