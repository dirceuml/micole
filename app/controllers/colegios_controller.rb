class ColegiosController < ApplicationController
  # GET /colegios
  # GET /colegios.json
  def index
    @colegios = Colegio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @colegios }
    end
  end

  # GET /colegios/1
  # GET /colegios/1.json
  def show
    @colegio = Colegio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @colegio }
    end
  end

  # GET /colegios/new
  # GET /colegios/new.json
  def new
    @colegio = Colegio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @colegio }
    end
  end

  # GET /colegios/1/edit
  def edit
    @colegio = Colegio.find(params[:id])
  end

  # POST /colegios
  # POST /colegios.json
  def create
    @colegio = Colegio.new(params[:colegio])

    respond_to do |format|
      if @colegio.save
        format.html { redirect_to @colegio, notice: 'Colegio was successfully created.' }
        format.json { render json: @colegio, status: :created, location: @colegio }
      else
        format.html { render action: "new" }
        format.json { render json: @colegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /colegios/1
  # PUT /colegios/1.json
  def update
    @colegio = Colegio.find(params[:id])

    respond_to do |format|
      if @colegio.update_attributes(params[:colegio])
        format.html { redirect_to @colegio, notice: 'Colegio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @colegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colegios/1
  # DELETE /colegios/1.json
  def destroy
    @colegio = Colegio.find(params[:id])
    @colegio.destroy

    respond_to do |format|
      format.html { redirect_to colegios_url }
      format.json { head :no_content }
    end
  end
end
