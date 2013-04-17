require 'digest/sha1'
require 'securerandom'
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.find_all_by_deleted(0)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
	if params[:password] == params[:password_confirmation] and params[:password].length >= 6
		@user = User.new(params[:user])
		@user.salt = SecureRandom.hex
		@hashed = @user.salt + params[:password]
		10.times do
			@hashed = Digest::SHA1.hexdigest(@hashed)
		end
		@user.hash_password = @hashed
		
		@user.deleted = 0;
		@user.admin = FALSE;
		
		respond_to do |format|
			if @user.save
				#session[:user_id] = @user.id
				redirect_to home_path
				#format.html { redirect_to @user, notice: 'User was successfully created.' }
				#format.json { render json: @user, status: :created, location: @user }
			else
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	else
		flash[:error] = "Password no es igual a la confirmacion o es muy corta"
		redirect_to "/users/new"
	end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
