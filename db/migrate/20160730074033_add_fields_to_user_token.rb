class AddFieldsToUserToken < ActiveRecord::Migration
  def change
    add_column :user_tokens, :token, :string
    add_column :user_tokens, :device_name, :string
    add_column :user_tokens, :is_valid, :bool
    add_column :user_tokens, :from, :timestamp
    add_column :user_tokens, :to, :timestamp
  end
end
