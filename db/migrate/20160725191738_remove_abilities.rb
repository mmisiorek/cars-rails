class RemoveAbilities < ActiveRecord::Migration
  def change
    drop_table :abilities
  end
end
