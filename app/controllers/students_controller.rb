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
    if !params[:student_id].nil?
      redirect_to "/students/#{params[:student_id]}"
      return 
    #elsif params[:subject].nil? && params[:gclass].nil? && session[:manager]
    #  @students = Student.all(:order => :name) 
    #elsif  params[:gclass].nil? && session[:manager]
    #  @students = Student.where(:subject => params[:subject]).order(:name)
    #elsif params[:subject].nil? && session[:manager]
    #  @students = Student.where(:gclass => params[:gclass]).order(:name)
    elsif session[:manager]
      @students = Student.all(:order=>:name)
    elsif !(session[:manager].nil? || params[:subject].nil? || params[:gclass].nil?) 
      @students = Student.where(:subject => params[:subject], :gclass=>params[:gclass]).order(:name)
    else 
      flash[:warning] = "You haven't permission to this action."
      redirect_to root_path
      return
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @report=Student.where(:student_id=>params[:id])
    if @report.nil? || @report.empty?
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
    gcl = params[:student][:gclass]
    subjects = Student.select(:subject).where(:gclass=> gcl).group(:subject).map {|elem| elem.subject}
    subjects = Teacher.select(:subject).where(:gclass=>gcl).group(:subject).map {|elem| elem.subject} if subjects.empty?
    if subjects.empty?
      redirect_to teachers_path, notice: "Student wasn't created! Please bind at least one teacher to class #{gcl} before."
      return
    end
    subjects.each  do |subj|
      Student.create(:name => params[:student][:name], :student_id =>params[:student][:student_id] ,:subject =>subj,:gclass=>gcl)
    end

    redirect_to '/managers/options', notice: "Student was successfully created."
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
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :ok }
    end
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
    tea=Teacher.where(:gclass => gclass).where(:subject=>subject).first
    tea.update_attributes!(:submitted=>submitted, :date_of_submission=>Date.current)
    @students = Student.update(params[:students].keys, params[:students].values).reject { |p| p.errors.empty? }
    if @students.empty?
      flash[:notice] = "OK - UPDATED"
    else
      flash[:warning] = "NOT UPDATED"
    end
    redirect_to "/teachers/#{tea.teacher_id}/choose_classes"
  end
end
