class ListasValoresController < ApplicationController
  load_and_authorize_resource
  
  # GET /listas_valores
  # GET /listas_valores.json
  def index
    @listas_valores = ListaValor.order("item") # ListaValor.all
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listas_valores }
    end
  end

  # GET /listas_valores/1
  # GET /listas_valores/1.json
  def show
    @lista_valor = ListaValor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lista_valor }
    end
  end

  # GET /listas_valores/new
  # GET /listas_valores/new.json
  def new
    @lista_valor = ListaValor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lista_valor }
    end
  end

  # GET /listas_valores/1/edit
  def edit
    @lista_valor = ListaValor.find(params[:id])
  end

  # POST /listas_valores
  # POST /listas_valores.json
  def create
    @lista_valor = ListaValor.new(params[:lista_valor])

    respond_to do |format|
      if @lista_valor.save
        format.html { redirect_to @lista_valor, notice: 'Lista valor was successfully created.' }
        format.json { render json: @lista_valor, status: :created, location: @lista_valor }
      else
        format.html { render action: "new" }
        format.json { render json: @lista_valor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /listas_valores/1
  # PUT /listas_valores/1.json
  def update
    @lista_valor = ListaValor.find(params[:id])

    respond_to do |format|
      if @lista_valor.update_attributes(params[:lista_valor])
        format.html { redirect_to @lista_valor, notice: 'Lista valor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lista_valor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listas_valores/1
  # DELETE /listas_valores/1.json
  def destroy
    @lista_valor = ListaValor.find(params[:id])
    @lista_valor.destroy

    respond_to do |format|
      format.html { redirect_to listas_valores_url }
      format.json { head :no_content }
    end
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to log_in_url, :alert => exception.message
    else
      redirect_to menu_url, :alert => exception.message
    end
  end
end
