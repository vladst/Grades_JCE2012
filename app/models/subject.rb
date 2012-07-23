class Subject < ActiveRecord::Base
  def self.destroy_subject(id)
    @subject = Subject.find(id)
    Student.where(:subject=>@subject.subject).destroy_all
    Teacher.where(:subject=>@subject.subject).destroy_all
    @subject.destroy
    @subject
  end
end
