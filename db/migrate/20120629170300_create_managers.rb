class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.integer :manager_id
      t.string :name
      t.string :password
      t.datetime :deadline
      t.integer :group

      t.timestamps
    end
  end
end
