class Admin::PublicationsController < ApplicationController

    before_filter :authenticate_user!, :except => [:show]
    before_filter :pub_params, :only => :create
    authorize_resource
    layout "admin/admin"
   
    def index
      @publications = Publication.accessible_by(current_ability).page(params[:page])
	     get_templates
 
    end
	
	def new
    @publication = Publication.new
	 get_templates
	end
	
	def show
    @publication = Publication.friendly.find(params[:id])
    respond_to do |format|
      format.rss 
      format.html {not_found}
    end
	end

	
	def create
      @publication = Publication.new(pub_params)
     	if @publication.save 
			flash[:success]= "Successfully created publication."
			redirect_to admin_publications_path
			else 
			@title = "New Publication"
			get_templates
			render :action => 'new'
    	end
	end
	
	def edit
    @publication = Publication.friendly.find(params[:id])
		get_templates
		@sections = Section.where(:publication_id => params[:id]).order('sections.position ASC')
	end	
	
	def update 
		params[:publication][:network_ids] ||= []
		@publication = Publication.friendly.find(params[:id])
		if @publication.update_attributes(pub_params)
			flash[:success]= "Successfully updated publication."
			if params[:redirect] == 'sections'
				redirect_to publication_sections_path(@publication)
			else
				redirect_to edit_admin_publication_path(@publication)
			end
			
		else
			render :action => 'edit'
			get_templates
			@title = "New Publication"
		end
	end
	def destroy
    @publication = Publication.friendly.find(params[:id])
		@publication.destroy
		flash[:success] = "Successfully removed publication."
		redirect_to admin_publications_path
	end

	def image_search
    if params[:title].present?
      @search_images = Image.where(['title LIKE ?', "#{params[:title]}%"])
    end
  end

  def not_found
    not_found_404
    redirect_to '/404'
  end

  def pub_params
    params.require(:publication).permit!
  end
	
end
