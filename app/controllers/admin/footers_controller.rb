class Admin::FootersController < ApplicationController
	
	before_filter :authenticate_user!
	before_filter :footer_params, :only => :create
	load_and_authorize_resource
	layout 'admin/admin'
	
	def index
		@title = "Footers"
	end
	
	def new  
		@title = "New Footer"
		render :layout => false
	end
	
	def create 
		if @footer.save
			flash[:success] = "Successfully created footer"
		end
		respond_to do |format|
			if @footer.save
      			format.html {redirect_to admin_footers_path}
				format.js
			else
				@title = "New footer"
				format.html { render :action => :new }
				format.js
			end
		end 
	end
	
	def edit
		render :layout => false
	end
	
	def update 
		@footer.update_attributes(footer_params)
			if @footer.save 
				flash[:success] = "Successfully update footer"
				if params[:redirect]
						redirect_to admin_footer_sections_path(@footer)
				else
						redirect_to admin_footers_path
				end
			else
				flash[:success] = "There was an issue updating the footer settings"
				if params[:redirect]
						redirect_to admin_footer_sections_path(@footer)
				else
						redirect_to admin_footers_path
				end
			end
	end
	
	def destroy
		@footer.destroy
		redirect_to admin_footers_path
	end

	def footer_params
		params.require(:footer).permit(:title)
	end
end
