class GclassesController < ApplicationController
  # GET /gclasses
  # GET /gclasses.json
  def index
    @gclasses = Gclass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gclasses }
    end
  end

  # GET /gclasses/1
  # GET /gclasses/1.json
  def show
    @gclass = Gclass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gclass }
    end
  end

  # GET /gclasses/new
  # GET /gclasses/new.json
  def new
    @gclass = Gclass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gclass }
    end
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
        format.html { redirect_to @gclass, notice: 'Gclass was successfully created.' }
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

    respond_to do |format|
      if @gclass.update_attributes(params[:gclass])
        format.html { redirect_to @gclass, notice: 'Gclass was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @gclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gclasses/1
  # DELETE /gclasses/1.json
  def destroy
    @gclass = Gclass.find(params[:id])
    @gclass.destroy

    respond_to do |format|
      format.html { redirect_to gclasses_url }
      format.json { head :ok }
    end
  end
end
