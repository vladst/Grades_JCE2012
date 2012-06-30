class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :teacher_id
      t.string :name
      t.string :subject
      t.string :gclass
      t.string :password
      t.integer :group

      t.timestamps
    end
  end
end
