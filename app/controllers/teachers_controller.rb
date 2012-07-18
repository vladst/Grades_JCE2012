class TeachersController < ApplicationController
  # GET /teachers
  # GET /teachers.json
  before_filter :require_login, :except => [:choose_classes]
   
  def require_login
    if !session[:manager]
      flash[:notice] = "You haven't permission to this action, please authorize as manager"
      redirect_to root_path
      return
    end
  end
  def index
    @teachers = Teacher.where(:group => session[:group]).order(:teacher_id)
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
        format.html { redirect_to teachers_path, notice: 'Success' }
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

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to teachers_url
  end
  
  #####################################
  def choose_classes
    if session[:manager].nil?
      flash[:notice] = "You haven't permission to this action, please authorize as teacher/manager"
      redirect_to root_path
      return
    end  
    teacherID = params[:id].nil? || params[:id].empty?? session[:id] : params[:id]
    @teacher_name = Teacher.select('name').where(:teacher_id => teacherID).first.name
    @possible_classes_submitted = Teacher.select('gclass, subject, date_of_submission').where(:teacher_id => teacherID).where(:submitted => true)
    @possible_classes_not_submitted = Teacher.select('gclass, subject').where(:teacher_id => teacherID).where(:submitted => false)
    @deadline = Manager.select(:deadline).where(:group => session[:group]).first.deadline
  end
  
  def add_class
    teach = Teacher.where(:teacher_id => params[:id]).first
    @teacher = Teacher.new(:teacher_id => teach.teacher_id, :group => session[:group], :name=> teach.name, :password=>teach.password, :submitted=>0)
    @possible_subjects = Subject.all.map {|elem| elem.subject }
    @possible_classes = Gclass.all.map {|elem| elem.gclass}
  end
end
