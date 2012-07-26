class TeachersController < ApplicationController
  # GET /teachers
  # GET /teachers.json
  before_filter :require_manager_login, :except => [:choose_classes]
   
  def require_manager_login
    if !session[:manager]
      flash[:warning] = "You haven't permission to this action, please authorize as manager"
      redirect_to root_path
      return
    end
  end
  
  def index
    @teachers = Teacher.get_teachers session[:group]
  end

  # GET /teachers/new
  # GET /teachers/new.json
  def new
    @teacher = Teacher.new(:group => session[:group], :submitted=>0)
    @possible_subjects = Subject.all.map {|elem| elem.subject }
    @possible_classes = Gclass.all.map {|elem| elem.gclass}
  end

  # GET /teachers/1/edit
  def edit
    @teacher = Teacher.find(params[:id])
  end

  # POST /teachers
  # POST /teachers.json
  def create   
    @teacher = Teacher.create_teacher(params[:teacher])
    if @teacher.nil?
      @teacher = Teacher.where(:subject => params[:teacher][:subject]).where(:gclass=>params[:teacher][:gclass]).first
      flash[:warning]= "Not possible to perform this action: Class #{params[:teacher][:gclass]} with subject #{params[:teacher][:subject]} alredy bounded to #{@teacher.name} (ID: #{@teacher.teacher_id})."
      redirect_to teachers_path
    else
      redirect_to "/teachers/#{@teacher.teacher_id}/choose_classes", notice: 'Success.'
    end
  end

  def unbind
    @teach = Teacher.unbind params[:id], params[:subject], params[:class]
    redirect_to "/teachers/#{@teach.teacher_id}/choose_classes", notice: "Teacher #{@teach.name} successfully unbounded from class #{@teach.gclass} #{@teach.subject}"
  end
  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    Teacher.destroy params[:id]
    redirect_to teachers_url, notice: "Teacher destroyed successfully!"
  end
  
  #####################################
  def choose_classes
    if session[:manager].nil?
      flash[:warning] = "You haven't permission to this action, please authorize as teacher/manager"
      redirect_to root_path
      return
    end 
    @teacherID = params[:id].nil? || params[:id].empty?? session[:id] : params[:id]
    @possible_classes_submitted = Teacher.possible_classes @teacherID, true
    @possible_classes_not_submitted = Teacher.possible_classes @teacherID, false
    @deadline = Manager.deadline session[:group]
  end
  
  def add_class
    @teacher = Teacher.newTeacherForBinding params[:id], session[:group]
    @possible_subjects = Subject.all.map {|elem| elem.subject }
    @possible_classes = Gclass.all.map {|elem| elem.gclass}
  end
end
