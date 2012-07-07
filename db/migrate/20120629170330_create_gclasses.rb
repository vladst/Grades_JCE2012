class CreateGclasses < ActiveRecord::Migration
  def change
    create_table :gclasses do |t|
      t.string :gclass

      t.timestamps
    end
  end
end
