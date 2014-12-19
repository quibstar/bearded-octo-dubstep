class Admin::HelpsController < ApplicationController

	before_filter :authenticate_user!
	before_filter :help_params, :only => :create
	load_and_authorize_resource
	layout 'admin/admin'
	
	def index
	  @helps = Help.all
	  @help_categories = HelpCategory.order(:title)
	end

	def new

		render :layout => false
	end

	def create 
	if @help.save 
		flash[:success]= "Help has been submitted."
		#create function to notify author
	redirect_to admin_helps_path
	else
		render 'new' 
		flash[:error]= "There was an issue with your help submission. Please try again."
		@title = "New Help"
	end
	end

	def edit
		@title = "Update Help"
		render :layout => false
	end

	def update 
		if @help.update_attributes(help_params)
			flash[:success]= "Successfully updated help."
    		redirect_to admin_helps_path
		else
			render :action => 'edit'
			@title = "New Help"
		end
	end

	def destroy 
		@help.destroy
		flash[:success] = "Successfully removed help."
		redirect_to admin_helps_path
	end

	def help_params
		params.require(:help).permit!
	end
end
