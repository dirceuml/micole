class CurriculosController < ApplicationController
  load_and_authorize_resource
  
  # GET /curriculos
  # GET /curriculos.json
  def index
    @curriculos = Curriculo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @curriculos }
    end
  end

  # GET /curriculos/1
  # GET /curriculos/1.json
  def show
    @curriculo = Curriculo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @curriculo }
    end
  end

  # GET /curriculos/new
  # GET /curriculos/new.json
  def new
    @curriculo = Curriculo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @curriculo }
    end
  end

  # GET /curriculos/1/edit
  def edit
    @curriculo = Curriculo.find(params[:id])
  end

  # POST /curriculos
  # POST /curriculos.json
  def create
    @curriculo = Curriculo.new(params[:curriculo])

    respond_to do |format|
      if @curriculo.save
        format.html { redirect_to @curriculo, notice: 'Curriculo was successfully created.' }
        format.json { render json: @curriculo, status: :created, location: @curriculo }
      else
        format.html { render action: "new" }
        format.json { render json: @curriculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /curriculos/1
  # PUT /curriculos/1.json
  def update
    @curriculo = Curriculo.find(params[:id])

    respond_to do |format|
      if @curriculo.update_attributes(params[:curriculo])
        format.html { redirect_to @curriculo, notice: 'Curriculo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @curriculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curriculos/1
  # DELETE /curriculos/1.json
  def destroy
    @curriculo = Curriculo.find(params[:id])
    @curriculo.destroy

    respond_to do |format|
      format.html { redirect_to curriculos_url }
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
