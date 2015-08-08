class AddBasicCarFields < ActiveRecord::Migration

  def up
    add_column :cars, :brand, :string
    add_column :cars, :model, :string
    add_column :cars, :manufactured_date, :datetime
  end

  def down
    remove_column :cars, :brand
    remove_column :cars, :model
    remove_column :cars, :manufactured_date
  end

end
