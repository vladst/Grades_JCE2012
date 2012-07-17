class ManagersController < ApplicationController
  
  before_filter :require_login
   
  def require_login
    unless session[:manager]
      flash[:notice] = "You haven't permission to this action, please authorize as manager"
      redirect_to "/"
      return
    end
  end
  # GET /managers
  # GET /managers.json
  def setTime #"" setting time for Teacher submission!
      
  end
  
  def index
    @managers = Manager.all
  end

  # GET /managers/1
  # GET /managers/1.json
  def show
    @manager = Manager.find(params[:id])
  end

  # GET /managers/new
  # GET /managers/new.json
  def new
    @manager = Manager.new
  end

  # GET /managers/1/edit
  def edit
    @manager = Manager.find(params[:id])
  end

  # POST /managers
  # POST /managers.json
  def create

    @manager = Manager.new(params[:manager])

    respond_to do |format|
      if @manager.save
        format.html { redirect_to @manager, notice: 'Manager was successfully created.' }
        format.json { render json: @manager, status: :created, location: @manager }
      else
        format.html { render action: "new" }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /managers/1
  # PUT /managers/1.json
  def update

    @manager = Manager.find(params[:id])

    respond_to do |format|
      if @manager.update_attributes(params[:manager])
        flash[:notice]= 'Manager was successfully updated.'
        redirect_to '/managers/options'
        return
      else
        format.html { render action: "edit" }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /managers/1
  # DELETE /managers/1.json
  def destroy

    @manager = Manager.find(params[:id])
    @manager.destroy

    respond_to do |format|
      format.html { redirect_to managers_url }
      format.json { head :ok }
    end
  end
  
  def options
    @manager=Manager.where(:manager_id => session[:id]).first
    
  end
end
