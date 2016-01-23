class FixPhotoColumnName < ActiveRecord::Migration
  def change
    rename_column :cars, :photo, :photo_id
  end
end
