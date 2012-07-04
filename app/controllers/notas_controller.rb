class NotasController < ApplicationController
  # GET /notas
  # GET /notas.json
  def index
    @notas = Nota.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notas }
    end
  end

  # GET /notas/1
  # GET /notas/1.json
  def show
    @nota = Nota.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nota }
    end
  end

  # GET /notas/new
  # GET /notas/new.json
  def new
    @nota = Nota.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nota }
    end
  end

  # GET /notas/1/edit
  def edit
    @nota = Nota.find(params[:id])
  end

  # POST /notas
  # POST /notas.json
  def create
    @nota = Nota.new(params[:nota])

    respond_to do |format|
      if @nota.save
        format.html { redirect_to @nota, notice: 'Nota was successfully created.' }
        format.json { render json: @nota, status: :created, location: @nota }
      else
        format.html { render action: "new" }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notas/1
  # PUT /notas/1.json
  def update
    @nota = Nota.find(params[:id])

    respond_to do |format|
      if @nota.update_attributes(params[:nota])
        format.html { redirect_to @nota, notice: 'Nota was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notas/1
  # DELETE /notas/1.json
  def destroy
    @nota = Nota.find(params[:id])
    @nota.destroy

    respond_to do |format|
      format.html { redirect_to notas_url }
      format.json { head :no_content }
    end
  end
end
