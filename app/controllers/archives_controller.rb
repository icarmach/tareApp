class ArchivesController < ApplicationController
  # GET /archives
  # GET /archives.json
  def index
    @archives = Archive.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archives }
    end
  end

  # GET /archives/1
  # GET /archives/1.json
  def show
    @archive = Archive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @archive }
    end
  end

  # GET /archives/new
  # GET /archives/new.json
  def new
    @archive = Archive.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @archive }
    end
  end

  # GET /archives/1/edit
  def edit
    @archive = Archive.find(params[:id])
  end

  # POST /archives
  # POST /archives.json
  def create
    @archive = Archive.new(params[:archive])
     #Obtenemos el ip y el id del usuario de la session
    userid = session[:user_id]
    userip = request.remote_ip
    #Revisamos que el usuario pueda subir el archivo para esta tarea

    #Agregamos el resto de las cosas manualmente
    @archive.ip = userip
    #Obtenemos la versión actual: si obtenemos un archivo anterior, obtenemos la versión, sino, version 1
    homeworkuser = HomeworkUser.find_by_homework_id_and_user_id(params[:homework_id], userid)
    if(homeworkuser.archives.nil?)
      #Get versión
      @archive.version = homeworkuser.archives.last.version+1
    else
      @archive.version = 1
    end
    @archive.homework_user_id = homeworkuser.id
    respond_to do |format|
      if @archive.save
        format.html { redirect_to @archive, notice: 'El archivo fue subido exitosamente.' }
        format.json { render json: @archive, status: :created, location: @archive }
      else
        format.html { render action: "new" }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /archives/1
  # PUT /archives/1.json
  def update
    @archive = Archive.find(params[:id])
    respond_to do |format|
      if @archive.update_attributes(params[:archive])
        format.html { redirect_to @archive, notice: 'El archivo fue subido exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archives/1
  # DELETE /archives/1.json
  def destroy
    @archive = Archive.find(params[:id])
    @archive.destroy

    respond_to do |format|
      format.html { redirect_to archives_url }
      format.json { head :no_content }
    end
  end
end
