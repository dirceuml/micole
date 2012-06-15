class CuadernoControlRevisionsController < ApplicationController
  # GET /cuaderno_control_revisions
  # GET /cuaderno_control_revisions.json
  def index
    @cuaderno_control_revisions = CuadernoControlRevision.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuaderno_control_revisions }
    end
  end

  # GET /cuaderno_control_revisions/1
  # GET /cuaderno_control_revisions/1.json
  def show
    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuaderno_control_revision }
    end
  end

  # GET /cuaderno_control_revisions/new
  # GET /cuaderno_control_revisions/new.json
  def new
    @cuaderno_control_revision = CuadernoControlRevision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuaderno_control_revision }
    end
  end

  # GET /cuaderno_control_revisions/1/edit
  def edit
    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])
  end

  # POST /cuaderno_control_revisions
  # POST /cuaderno_control_revisions.json
  def create
    @cuaderno_control_revision = CuadernoControlRevision.new(params[:cuaderno_control_revision])

    respond_to do |format|
      if @cuaderno_control_revision.save
        format.html { redirect_to @cuaderno_control_revision, notice: 'Cuaderno control revision was successfully created.' }
        format.json { render json: @cuaderno_control_revision, status: :created, location: @cuaderno_control_revision }
      else
        format.html { render action: "new" }
        format.json { render json: @cuaderno_control_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuaderno_control_revisions/1
  # PUT /cuaderno_control_revisions/1.json
  def update
    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])

    respond_to do |format|
      if @cuaderno_control_revision.update_attributes(params[:cuaderno_control_revision])
        format.html { redirect_to @cuaderno_control_revision, notice: 'Cuaderno control revision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuaderno_control_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuaderno_control_revisions/1
  # DELETE /cuaderno_control_revisions/1.json
  def destroy
    @cuaderno_control_revision = CuadernoControlRevision.find(params[:id])
    @cuaderno_control_revision.destroy

    respond_to do |format|
      format.html { redirect_to cuaderno_control_revisions_url }
      format.json { head :no_content }
    end
  end
end
