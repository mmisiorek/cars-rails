class AddUserRelation < ActiveRecord::Migration
  def change
    add_reference :documents, :user, foreign_key: true
    add_reference :cars, :user, foreign_key: true
  end
end
