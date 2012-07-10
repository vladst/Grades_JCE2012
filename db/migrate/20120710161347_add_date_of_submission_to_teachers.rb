class AddDateOfSubmissionToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :date_of_submission, :date
  end
end
