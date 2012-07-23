class Gclass < ActiveRecord::Base
  def self.findClassIdByStudent(id)
    gclass=Student.where(:student_id=>id).first.gclass
    Gclass.where(:gclass=>gclass).first.id
  end
end
