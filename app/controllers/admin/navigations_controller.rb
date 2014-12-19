class Admin::NavigationsController < ApplicationController
	
	before_filter :authenticate_user!
	before_filter :nav_params, :only => :create
	authorize_resource

	layout 'admin/admin'
	
	def index 
		@navigations = Navigation.order(:id)
		@title = 'Navigation Groups'
		get_templates
	end
	
	def show
		@navigation = Navigation.find(params[:id])
		@title = @navigation.nav_group.capitalize
	end
	
	def new 
		@navigation = Navigation.new
		@title = "New Navigation Group"
		render :layout => false
	end
	
	def create 
		@navigation = Navigation.new(nav_params)
		if @navigation.save 
			flash[:success]= "Successfully created navigation group."
      		redirect_to admin_navigations_path
		else
			render new 
			@title = "New Navigation Group"
		end
	end
	
	def edit
		@navigation = Navigation.find(params[:id])
		@title = @navigation.nav_group.capitalize
		render :layout => false
	end
	
	def update
	 	@navigation = Navigation.find(params[:id])
		if @navigation.update_attributes(params[:navigation])
			flash[:success]= "Successfully updated navigation group."
			if(params[:redirect])
				redirect_to navigation_path(@navigation.id)
			else
    		redirect_to admin_navigations_path
    	end
		else
			flash
			render 'edit'
			@title = "New Navigation Group"
		end
	end
	
	def destroy
		@navigation = Navigation.find(params[:id])
		@navigation.destroy
		redirect_to admin_navigations_path
	end
	
	def nav_params
		params.require(:navigation).permit(:nav_group, :description)
	end
end
