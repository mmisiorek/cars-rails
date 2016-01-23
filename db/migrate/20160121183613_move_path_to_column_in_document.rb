class MovePathToColumnInDocument < ActiveRecord::Migration
  def change
    add_column :documents, :path, :string
  end
end
