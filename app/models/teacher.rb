class Teacher < ActiveRecord::Base
  def self.get_teachers (group)
    Teacher.where(:group => group).group(:teacher_id)
  end
  
  def self.create_teacher (teach)
    return nil unless Teacher.where(:subject=>teach[:subject]).where(:gclass=>teach[:gclass]).empty?
    @teacher = Teacher.new(teach)
    students = Student.where(:gclass=>teach[:gclass]).group(:student_id)
    students.each do |student|
      Student.create(:name => student.name, :student_id =>student.student_id ,:subject =>teach[:subject],:gclass=>teach[:gclass])
    end
    @teacher.save
    @teacher
  end
  
  def self.unbind (id, subject, gclass)
    @teach=Teacher.where(:teacher_id=>id).where(:subject=>subject).where(:gclass=>gclass).first
    Student.where(:gclass=>@teach.gclass).where(:subject=>@teach.subject).destroy_all
    @teach.destroy
    return @teach
  end
  
  def self.destroy (id)
    teachers = Teacher.where(:teacher_id=>Teacher.find(id).teacher_id)
    teachers.each do |teacher|
      Student.where(:gclass=>teacher.gclass).where(:subject=>teacher.subject).destroy_all
    end
    teachers.destroy_all
  end
  
  def self.possible_classes (id, submitted)
    Teacher.where(:teacher_id => id).where(:submitted => submitted)
  end
  
  def self.newTeacherForBinding (id, group)
    teach = Teacher.where(:teacher_id => id).first
    @teacher = Teacher.new(:teacher_id => teach.teacher_id, :group => group, :name=> teach.name, :password=>teach.password, :submitted=>0)
  end
end
