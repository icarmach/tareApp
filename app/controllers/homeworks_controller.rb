require 'digest/sha1'
require 'securerandom'
class HomeworksController < ApplicationController
  # GET /homeworks
  # GET /homeworks.json
  def index
    @user = User.find(session[:user_id])
    @my_homeworks = @user.homeworks
	
	@other_homeworks = Array.new
	@user.homework_users.each do |hu|
		@other_homeworks.push(hu.homework_id)
	end
	
	@other_homeworks.uniq!

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @homeworks }
    end
  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
    @homework = Homework.find(params[:id])
    #Revisamos si es alumno
    @homeworkuser = HomeworkUser.find_by_homework_id_and_user_id(params[:id], session[:user_id])

    if(@homework.user_id == session[:user_id])
      #Conseguimos los archivos de todos los alumnos
      @userarchives = Array.new
      @homework.homework_users.each do |hu|
             @userarchives.push(hu.archives)
      end

       respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @homework }
        end
        
    else
      if( @homeworkuser)
      #Si lo es, mostramos todos sus archivos con las versiones subidas
        @archives = Archive.find_all_by_homework_user_id(@homeworkuser.id)
         respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @homework }
          end
      else
      #Mostrar error: usted no pertenece a esta tarea
        respond_to do |format|
          format.html { redirect_to home_path, notice: 'Error: Usted no pertenece a esta tarea'}
        end
      end
    end
    
  end

  # GET /homeworks/new
  # GET /homeworks/new.json
  def new
    @homework = Homework.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @homework }
    end
  end

  # GET /homeworks/1/edit
  def edit
    @homework = Homework.find(params[:id])
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @homework = Homework.new(params[:homework])
    @homework.deadline = @homework.deadline + 4.hours
    userid = session[:user_id]
	if(User.find(userid).homeworks.count >= 20)
		@homework.errors.add(:user_id, "Usted ya tiene veinte o mas tareas")
		respond_to do |format|
			format.html { render action: "new" }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		end
	else
		@homework.user_id = userid
		@homework.path = @homework.description_file.url
		respond_to do |format|
			if @homework.save
				params[:invitados].split(';').each do |g|
					if(!User.exists?(:email => g.delete(' ')))
						@user = User.new
						@user.email = g.delete(' ')
						@user.name = "Firstname"
						@user.lastname = "Lastname"
						@user.admin = false
						@user.salt = SecureRandom.hex
						@user.hash_password = SecureRandom.hex
						@user.deleted = 0
						@user.save
						
						@hu = HomeworkUser.new
						@hu.user_id = @user.id
						@hu.homework_id = @homework.id
						@hu.save
						
						begin
							UserMailer.first_invitation_email(@homework, @user).deliver
						rescue
						end
					else
						@user = User.find_by_email(g.delete(' '))
						@hu = HomeworkUser.new
						@hu.user_id = @user.id
						@hu.homework_id = @homework.id
						@hu.save
						begin
							UserMailer.invitation_email(@homework, @user).deliver
						rescue
						end
					end
				end
				format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
				format.json { render json: @homework, status: :created, location: @homework }
			else
				format.html { render action: "new" }
				format.json { render json: @homework.errors, status: :unprocessable_entity }
			end
		end
	end
  end

  # PUT /homeworks/1
  # PUT /homeworks/1.json
  def update
    @homework = Homework.find(params[:id])
    @homework.deadline = @homework.deadline + 4.hours

    respond_to do |format|
      if @homework.update_attributes(params[:homework])
        format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework = Homework.find(params[:id])
    @homework.destroy

    respond_to do |format|
      format.html { redirect_to homeworks_url }
      format.json { head :no_content }
    end
  end
  
	def search
		if(params[:simple_query].size > 0)
			flash.now[:searchinfo] = "Busqueda por nombre #{params[:simple_query]}"
			@homeworks = Homework.find(:all, :conditions=>['name LIKE ?', "%#{params[:simple_query]}%"])
		else
			@homeworks = Homework.all;
		end
		respond_to do |format|
			format.html
			format.json
		end
	end
	
	def upload
    @homework = Homework.find(params[:homework_id])
    #Revisar si el usuario efectivamente puede subir el archivo aca
    @homeworkuser = HomeworkUser.find_all_by_homework_id_and_user_id(params[:homework_id], session[:user_id])
    if( @homeworkuser )
      @archive = Archive.new
      respond_to do |format|
        format.html
        format.json
      end
    else
      format.html { redirect_to home_path, notice: 'Error : Usted no tiene acceso a esta tarea' }
    end
  end
  
end
