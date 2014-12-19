class Admin::MultiNavigationsController < ApplicationController

	before_filter :authenticate_user!
	before_filter :multi_nav_params, :only => :create
	load_and_authorize_resource
	layout 'admin/admin'

	def index
		@multi_navigations = MultiNavigation.order(:id)
		@title = "Multi-Navigations"
	end

	def show
		@multi_navigation = MultiNavigation.find(params[:id])
	end

	def new
		@multi_navigation = MultiNavigation.new
		@title = "New multi-navigation"
		render :layout => false
	end

	def create
		if @multi_navigation.save 
			flash[:success]= "Successfully created multi-navigation menu."
		end
		respond_to do |format|
			if @multi_navigation.save
      			format.html {redirect_to admin_multi_navigations_path}
				format.js
			else
				@title = "New multi-navigation"
				format.html { render :action => :new }
				format.js
			end
		end
	end

	def edit
		@title = "Edit multi-navigation"
		render :layout => false
	end

	def update 
		if @multi_navigation.update_attributes(multi_nav_params)
			flash[:success]= "Successfully updated multi-navigation menu."
		end
		respond_to do |format|
			if @multi_navigation.save
				# redirect for editing on navigation/:id/sections
				if params[:redirect]
					format.html {redirect_to admin_multi_navigation_sections_path(@multi_navigation)}
				else
					format.html {redirect_to  admin_multi_navigations_path}
				end
				format.js
			else
				@title = "Edit multi-navigation"
				format.html { render :action => :edit }
				format.js
			end
		end
	end
	
	def destroy
		@multi_navigation.destroy
		pages = Page.where(:multi_navigation_id => @multi_navigation)
		pages.each do |p|
			p.update_attributes(:multi_navigation_id => '')
		end
		sections = Section.where(:multi_navigation_id => @multi_navigation)
		sections.each do |s|
			s.destroy
		end
		redirect_to admin_multi_navigations_path
	end

	def multi_nav_params
		params.require(:multi_navigation).permit!
	end
end
