class TransaccionesController < ApplicationController
  # GET /transacciones
  # GET /transacciones.json
  def index
    @transacciones = Transaccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transacciones }
    end
  end

  # GET /transacciones/1
  # GET /transacciones/1.json
  def show
    @transaccion = Transaccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaccion }
    end
  end

  # GET /transacciones/new
  # GET /transacciones/new.json
  def new
    @transaccion = Transaccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaccion }
    end
  end

  # GET /transacciones/1/edit
  def edit
    @transaccion = Transaccion.find(params[:id])
  end

  # POST /transacciones
  # POST /transacciones.json
  def create
    @transaccion = Transaccion.new(params[:transaccion])

    respond_to do |format|
      if @transaccion.save
        format.html { redirect_to @transaccion, notice: 'Transaccion was successfully created.' }
        format.json { render json: @transaccion, status: :created, location: @transaccion }
      else
        format.html { render action: "new" }
        format.json { render json: @transaccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transacciones/1
  # PUT /transacciones/1.json
  def update
    @transaccion = Transaccion.find(params[:id])

    respond_to do |format|
      if @transaccion.update_attributes(params[:transaccion])
        format.html { redirect_to @transaccion, notice: 'Transaccion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transacciones/1
  # DELETE /transacciones/1.json
  def destroy
    @transaccion = Transaccion.find(params[:id])
    @transaccion.destroy

    respond_to do |format|
      format.html { redirect_to transacciones_url }
      format.json { head :no_content }
    end
  end
end
