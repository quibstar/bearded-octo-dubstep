class Admin::SharedContentsController < ApplicationController

	before_filter :authenticate_user!
	before_filter :shared_params, :only => :create
	load_and_authorize_resource
	layout 'admin/admin'
	
	def index
		@sharedContents = SharedContent.all
		@title = "Shared Content"
		@sections = Section.where(:section_type => "shared content")
		@publications = Publication.all
		@footers = Footer.all
	end

	def show
		@shared_content = SharedContent.find(params[:id])
	end

	def new
		@title = "New shared content"
		render :layout => false
	end

	def create
		if @shared_content.save
			flash[:success]= "Successfully created new menu."
		end
		respond_to do |format|
			if @shared_content.save
      			format.html {redirect_to admin_shared_contents_path}
				format.js
			else
				@title = "New shared content"
				format.html { render :action => :new }
				format.js
			end
		end 
	end

	def edit
		@title = "Edit shared content"
		render :layout => false
	end
	
	def update 
		if @shared_content.update_attributes(shared_params)
			flash[:success]= "Successfully updated shared content menu."	
		end
		respond_to do |format|
			if @shared_content.save
				if params[:redirect]
					format.html {redirect_to admin_shared_content_sections_path(@shared_content)}
				else
					format.html {redirect_to admin_shared_contents_path}
				end
				format.js
			else
				@title = "Edit shared content"
				format.html { render :action => :edit }
				format.js
			end
		end

	end
	
	def destroy
		@shared_content.destroy
		sections = Section.where(:shared_content_id => @shared_content)
		sections.each do |s|
			s.destroy
		end
		redirect_to admin_shared_contents_path
	end

	def shared_params
		params.required(:shared_content).permit!
	end
end
