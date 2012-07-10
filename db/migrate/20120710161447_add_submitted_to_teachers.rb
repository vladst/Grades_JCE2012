class AddSubmittedToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :submitted, :boolean
  end
end
