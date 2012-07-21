class TeachersController < ApplicationController
  # GET /teachers
  # GET /teachers.json
  before_filter :require_login, :except => [:choose_classes]
   
  def require_login
    if !session[:manager]
      flash[:warning] = "You haven't permission to this action, please authorize as manager"
      redirect_to root_path
      return
    end
  end
  def index
    @teachers = Teacher.where(:group => session[:group]).group(:teacher_id)
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    @teacher = Teacher.find(params[:id])
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
    @teacher = Teacher.new(params[:teacher])
    students = Student.where(:gclass=>@teacher.gclass)
    students.each do |student|
      Student.create(:name => student.name, :student_id =>student.student_id ,:subject =>params[:teacher][:subject],:gclass=>params[:teacher][:gclass])
    end
    respond_to do |format|
      if @teacher.save
        format.html { redirect_to "/teachers/#{@teacher.teacher_id}/choose_classes", notice: 'Success.' }
        format.json { render json: @teacher, status: :created, location: @teacher }
      else
        format.html { render action: "new" }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teachers/1
  # PUT /teachers/1.json
  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def unbind
    @teach=Teacher.where(:teacher_id=>params[:id]).where(:subject=>params[:subject]).where(:gclass=>params[:class]).first
    Student.where(:gclass=>@teach.gclass).where(:subject=>@teach.subject).destroy_all
    @teach.destroy
    redirect_to "/teachers/#{@teach.teacher_id}/choose_classes", notice: "Teacher successfully unbounded from class #{@teach.gclass} #{@teach.subject}"
  end
  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    teachers = Teacher.where(:teacher_id=>Teacher.find(params[:id]).teacher_id)
    teachers.each do |teacher|
      Student.where(:gclass=>teacher.gclass).where(:subject=>teacher.subject).destroy_all
      teacher.destroy
    end
    redirect_to teachers_url, notice: "Teacher destroyed successfully #{params.inspect}!"
  end
  
  #####################################
  def choose_classes
    if session[:manager].nil?
      flash[:warning] = "You haven't permission to this action, please authorize as teacher/manager"
      redirect_to root_path
      return
    end  
    @teacherID = params[:id].nil? || params[:id].empty?? session[:id] : params[:id]
    @possible_classes_submitted = Teacher.where(:teacher_id => @teacherID).where(:submitted => true)
    @possible_classes_not_submitted = Teacher.select('gclass, subject, id').where(:teacher_id => @teacherID).where(:submitted => false)
    @deadline = Manager.select(:deadline).where(:group => session[:group]).first.deadline
  end
  
  def add_class
    teach = Teacher.where(:teacher_id => params[:id]).first
    @teacher = Teacher.new(:teacher_id => teach.teacher_id, :group => session[:group], :name=> teach.name, :password=>teach.password, :submitted=>0)
    @possible_subjects = Subject.all.map {|elem| elem.subject }
    @possible_classes = Gclass.all.map {|elem| elem.gclass}
  end
end
