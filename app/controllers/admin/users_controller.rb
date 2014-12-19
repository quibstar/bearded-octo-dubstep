class Admin::UsersController < ApplicationController
	
	before_filter :get_user, :only => [:index,:new,:edit]
	before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
	before_filter :user_params, :only => :create
	authorize_resource :only => [:show,:new,:destroy,:edit,:update]
	
	layout "admin/admin"
	
		def index 
		    if params[:user].present?
		    @user = User.find(params[:user])
		    redirect_to edit_admin_user_path(@user)
	    else
			# 25 default .per(50)
			@users = User.all
			@title = 'Users'
		end
	end
	
	def new 
		@user = User.new
		@title = "New User"
	end
	
	def create 
		@user = User.new(params[:user])
		if @user.save 
			flash[:success]= "Successfully created User."
      		redirect_to admin_users_path
		else
			render :action => 'new' 
			@title = "New User"
		end
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update 
		@user = User.find(params[:id])
		if params[:user][:password].blank?
	      [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
	    else
	      @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
	    end
	    
		if @user.errors[:base].empty? and @user.update_attributes(user_params)
			flash[:success]= "Successfully updated User."
				redirect_to edit_admin_user_path(@user)
		else
			flash[:error]= "Error updating User."
			render 'edit'
			@title = "Edit User"
		end
	end
	
	def destroy
		@user = User.find(params[:id])

		@user.asset_categories.each do |ac|
			ac.destroy
		end

		@user.destroy
		redirect_to admin_users_path
	end
	
	# Get roles accessible by the current user
	#----------------------------------------------------
	def accessible_roles
		@accessible_roles = Role.accessible_by(current_ability,:read)
	end
	
	# Make the current user object available to views
	#----------------------------------------
	def get_user
		if current_user
			@current_user = current_user	
		else
			redirect_to root_path
		end
		
	end

	def update_password
		if @user.update_attributes(user_params)
		  # Sign in the user by passing validation in case his password changed
		  sign_in @user, :bypass => true
		  redirect_to root_path
		else
		  render "edit"
		end
  end

  def generate_new_password_email
    user = User.find(params[:user_id])
    user.send_reset_password_instructions
    flash[:notice] = "Reset password instructions have been sent to #{user.email}."
    redirect_to admin_users_path
   end

   def user_params
   	params.require(:user).permit!
   end
  
end
