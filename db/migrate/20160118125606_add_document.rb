class AddDocument < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :original_filename
      t.string :real_filename
      
      t.timestamps null: false
    end
  end
end
