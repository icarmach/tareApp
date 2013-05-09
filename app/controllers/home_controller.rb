require 'digest/sha1'
class HomeController < ApplicationController

	def index
		if session[:user_id]
			@user = User.find(session[:user_id])
			@my_homeworks = @user.homeworks
	
			@other_homeworks = Array.new
			@user.homework_users.each do |hu|
				@other_homeworks.push(hu.homework_id)
			end
	
			@other_homeworks.uniq!
		end
		if params[:commit] == "Login"
			if User.exists?(:email => params[:email])
				@user = User.find_by_email(params[:email])
				@salt = @user.salt
				@hashed = @salt + params[:password]
				10.times do
					@hashed = Digest::SHA1.hexdigest(@hashed)
				end
				if @hashed == @user.hash_password
					session[:user_id] = @user.id

					@my_homeworks = @user.homeworks
	
					@other_homeworks = @user.other_homeworks()
					
					render "index.html.erb"
				else
					flash.now[:error] = "Nombre de usuario o password equivocado"
					render "index.html.erb"
				end
			else
				flash.now[:error] = "Nombre de usuario o password equivocado"
				render "index.html.erb"
			end
		else 
			if params[:commit] == "Sign Up"
				redirect_to "/users/new"
			else
				render "index.html.erb"
			end
		end
	end
	
	def logout
		reset_session
		render "index.html.erb"
	end
	
	def admin
		if !session[:user_id]
			flash[:error] = "Acceso denegado, se ha creado un registro del incidente"
			::Rails.logger.error("\n #{Time.now.strftime("%d/%m/%Y %H:%M	")} ERORR: Usuario no identificado intenta acceso a /Administracion \n")
			redirect_to home_path
		else
			if !User.find(session[:user_id]).admin
				flash[:error] = "Acceso denegado, se ha creado un registro del incidente"
				::Rails.logger.error("\n #{Time.now.strftime("%d/%m/%Y %H:%M	")} ERORR: Usuario #{User.find(session[:user_id]).email} intenta acceso a /Administracion \n")
				redirect_to home_path
			else
				respond_to do |format|
					format.html # index.html.erb
					format.json { render json: @users }
				end
			end
		end
	end

end
