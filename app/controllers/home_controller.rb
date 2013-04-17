require 'digest/sha1'
class HomeController < ApplicationController

	def index
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
				else
					flash.now[:error] = "Nombre de usuario o password equivocado"
				end
			else
				flash.now[:error] = "Nombre de usuario o password equivocado"
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

end
