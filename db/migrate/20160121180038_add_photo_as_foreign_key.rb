class AddPhotoAsForeignKey < ActiveRecord::Migration
  def change
    remove_reference :cars, :document
    
    add_column :cars, :photo, :integer
    add_foreign_key :cars, :document, column: :photo 
    add_index :cars, :photo
  end
end
