class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :student_id
      t.string :name
      t.string :subject
      t.string :gclass
      t.integer :grade
      t.string :note

      t.timestamps
    end
  end
end
