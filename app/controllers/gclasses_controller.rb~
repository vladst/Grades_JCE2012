class GclassesController < ApplicationController
  before_filter :require_login
   
  def require_login
    if !session[:manager]
      flash[:notice] = "You haven't permission to this action, please authorize as manager"
      redirect_to "/"
      return
    end
  end
  
  # GET /gclasses
  # GET /gclasses.json
  def index
    @gclasses = Gclass.all :order => :gclass
  end

  # GET /gclasses/1
  # GET /gclasses/1.json
  def show
    @gclass = Gclass.find(params[:id])
    @students=Student.select("subject, name, grade, student_id").where(:gclass=>@gclass.gclass)
    @subjects=@students.group(:subject)
  end

  # GET /gclasses/new
  # GET /gclasses/new.json
  def new
    @gclass = Gclass.new
  end

  # GET /gclasses/1/edit
  def edit
    @gclass = Gclass.find(params[:id])
  end

  # POST /gclasses
  # POST /gclasses.json
  def create
    @gclass = Gclass.new(params[:gclass])

    respond_to do |format|
      if @gclass.save
        format.html { redirect_to @gclass, notice: 'Class was successfully created.' }
        format.json { render json: @gclass, status: :created, location: @gclass }
      else
        format.html { render action: "new" }
        format.json { render json: @gclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gclasses/1
  # PUT /gclasses/1.json
  def update
    @gclass = Gclass.find(params[:id]) 
    Student.where(:gclass=>@gclass.gclass).update_all(:gclass=>params[:gclass][:gclass])
    Teacher.where(:gclass=>@gclass.gclass).update_all(:gclass=>params[:gclass][:gclass])
    @gclass.update_attributes(params[:gclass])
    redirect_to @gclass, notice: "Class was successfully updated to #{params[:gclass][:gclass]}."
  end

  # DELETE /gclasses/1
  # DELETE /gclasses/1.json
  def destroy
    @gclass = Gclass.find(params[:id])
    Student.where(:gclass=>@gclass.gclass).destroy_all
    Teacher.where(:gclass=>@gclass.gclass).destroy_all
    @gclass.destroy
    redirect_to gclasses_url, notice: "Class destroyed, all students removed from the DataBase!"
  end
end
