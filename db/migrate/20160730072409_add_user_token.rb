class AddUserToken < ActiveRecord::Migration
  def change
    add_reference :user_tokens, :user, token: true
  end
end
