class MoreFieldsToCars < ActiveRecord::Migration
  def up
    add_column :cars, :photo_file_name, :string
    add_column :cars, :registration_number, :string
    add_column :cars, :is_available, :boolean
  end

  def down
    remove_column :cars, :photo_file_name
    remove_column :cars, :registration_number
    remove_column :cars, :is_available
  end
end
