class HomeController < ApplicationController

	def index
		if params[:commit] == "Login"
			if User.exists?(:email => params[:email])
				@user = User.find_by_email(params[:email])
				#Password check
				if @user.password == Base64.encode64(params[:password])
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

end
