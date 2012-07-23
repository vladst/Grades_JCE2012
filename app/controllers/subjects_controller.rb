class SubjectsController < ApplicationController
  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @subject = Subject.find(params[:id])
  end

  # GET /subjects/new
  # GET /subjects/new.json
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(params[:subject])

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_url, notice: 'Subject was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.json
  def update
    @subject = Subject.find(params[:id])
    Student.where(:subject=>@subject.subject).update_all(:subject=>params[:subject][:subject])
    Teacher.where(:subject=>@subject.subject).update_all(:subject=>params[:subject][:subject])
    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject = Subject.destroy_subject params[:id]
    redirect_to subjects_url, notice: "Subject #{@subject.subject} destroyed successfully."
  end
end
