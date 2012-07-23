class Student < ActiveRecord::Base
  def self.getStudentsList(subject, gclass)
    if !subject.blank? && !gclass.blank?
      Student.where(:subject => subject, :gclass=>gclass).order(:name)
    elsif !subject.blank?
      Student.where(:subject => subject).order(:gclass, :name)
    elsif !gclass.blank?
      Student.where(:gclass => gclass).order(:subject, :name)
    else
      Student.all(:order=>:name)
    end
  end
  
  def self.createNew(student)
    gcl = student[:gclass] 
    subjects = Teacher.select(:subject).where(:gclass=>gcl).group(:subject).map {|elem| elem.subject}
    return false if subjects.empty?
    subjects.each  do |subj|
      Student.create(:name => student[:name], :student_id =>student[:student_id] ,:subject =>subj,:gclass=>gcl)
    end
    return true
  end
end
