class StudentsController < ApplicationController
  # GET /students
  # GET /students.json
  def index
    #@students = Student.all
    if params[:subject].nil? || params[:gclass].nil?
      @students = Student.all
      @main_form="",""
    else  
      @main_form="",""
      @students = Student.where(:subject => params[:subject], :gclass=>params[:gclass])
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @students }
      end
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
    @possible_classes = Gclass.all.map {|elem| elem.gclass}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
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
    #@student = Student.new(params[:student])
    subjects.each  do |subj|
      Student.create(:name => params[:student][:name], :student_id =>params[:student][:student_id] ,:subject =>subj,:gclass=>gcl)
    end
    format.html { redirect_to students_path, notice: "Student was successfully created." }
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
  def test
    flash[:notice]=params.inspect
    redirect_to teachers_path
  end
  
  def update_individual
    @students = Student.update(params[:students].keys, params[:students].values).reject { |p| p.errors.empty? }
    if @students.empty?
      flash[:notice] = "OK -UPDATED"
      redirect_to students_path
    else
      redirect_to teachers_path
    end
  end
end
