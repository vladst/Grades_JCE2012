class StudentsController < ApplicationController
  # GET /students
  # GET /students.json
  before_filter :require_login, :except => [:index, :update_individual]
   
  def require_login
    if !session[:manager]
      flash[:warning] = "You haven't permission to this action, please authorize as manager"
      redirect_to root_path
      return
    end
  end

  def index
    if session[:manager].nil? || (!session[:manager]&& (params[:gclass].blank? || params[:subject].blank?) )
      flash[:warning] = "You haven't permission to this action."
      redirect_to root_path
    elsif !params[:student_id].nil?
      redirect_to "/students/#{params[:student_id]}"
      return 
    else session[:manager]
      @students = Student.getStudentsList params[:subject], params[:gclass]
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @report=Student.where(:student_id=>params[:id])
    if @report.blank?
      flash[:warning]="Student with id #{params[:id]} not found"
      redirect_to '/managers/options'
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
    @possible_classes = Gclass.all.map {|elem| elem.gclass}
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    
    answer = Student.createNew(params[:student])
    redirect_to teachers_path, notice: "Student wasn't created! Please bind at least one teacher to class #{gcl} before." unless answer

    redirect_to "/gclasses/#{Gclass.where(:gclass=>params[:student][:gclass]).first.id}", notice: "Student was successfully created."
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
       format.html { redirect_to @student, notice: params[:student]}#'Debug: #{params[:student]} Student was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    gclass = Gclass.findClassIdByStudent params[:id]
    @stu = Student.destroy_student params[:id]
    redirect_to "/gclasses/#{gclass}", notice: "Student destroyed."
  end
  
  #################################################################################
  
  def update_individual
    if session[:manager].nil?
      flash[:warning] = "You haven't permission to this action, please authorize as manager/teacher"
      redirect_to root_path
      return
    end
    submitted = !params[:submitted].nil?
    gclass = params[:students].values.first[:gclass]
    subject = params[:students].values.first[:subject]
    
    tea = Teacher.update_teachers_submission(gclass, subject, submitted)
    
    @students = Student.update_individual(params[:students])
    if @students.empty?
      flash[:notice] = "UPDATED"
    else
      flash[:warning] = "NOT UPDATED"
    end
    
    redirect_to "/teachers/#{tea.teacher_id}/choose_classes"
  end
end
