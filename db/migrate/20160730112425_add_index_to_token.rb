class AddIndexToToken < ActiveRecord::Migration
  def change
    add_index :user_tokens, :token
    add_index :user_tokens, :is_valid
  end
end
