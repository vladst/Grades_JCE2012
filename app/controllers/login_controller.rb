class LoginController < ApplicationController
  def index
  end
  
  def choose_classes
    #@classes = Gclasses.group(:class_id).select(:class_id).map {|elem| elem.class_id}
    teacherID = 12345 #params[:teacherID]
    @possible_classes = Teacher.group(:class_id).select(:class_id).where(:teacher_id => teacherID).map {|elem| elem.class_id}
    @possible_subjects = Teacher.group(:subject).select(:subject).where(:teacher_id => teacherID).map {|elem| elem.subject}
  end
  
  def auth
    pass=params[:Password]
    id=params[:user]
    passFromDB=Teacher.select(:password).where(:teacher_id => id)
    if !(passFromDB.nil? || passFromDB.empty?) && passFromDB.first.password == pass
      redirect_to "/teachers/#{id}/choose_classes"
    else
      flash[:notice] = "Pair of login and password not found"
      redirect_to "/"
    end
  end
end
