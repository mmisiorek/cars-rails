class AddPhotoToCar < ActiveRecord::Migration
  def change
    add_reference :cars, :document, index: true, foreign_key: true
  end
end
