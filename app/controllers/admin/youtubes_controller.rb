class Admin::YoutubesController < ApplicationController

	before_filter :authenticate_user!
  before_filter :youtube_params, :only => :create
	authorize_resource
	layout 'admin/admin'
	
  def index
    @youtubes = Youtube.order(:id)
    @title = "YouTube Videos"
  end
  
  def new
    @youtube = Youtube.new
    render :layout => false
  end
  
	def create 
    @YouTube = @youtube = Youtube.new(youtube_params)
		if @youtube.save 
			flash[:success]= "Youtube has been submitted."
      redirect_to admin_youtubes_path
		else
      @title = "New Youtube"
      render :action => :new 
    end
	end
	
	def edit
    @youtube = Youtube.find(params[:id])
		@title = "Update Youtube"
    render :layout => false
	end
	
	def update
    @youtube = Youtube.find(params[:id])
		if @youtube.update_attributes(youtube_params)
			flash[:success]= "Successfully updated youtube."
      redirect_to admin_youtubes_path()
      else
        render :action => 'edit'
        @title = "Edit Youtube"
      end
	end
	
	def destroy
    @youtube = Youtube.find(params[:id])
    @youtube.asset_categories.each do |ac|
      ac.destroy
    end
    @youtube.destroy
    flash[:success] = "Successfully removed youtube."
    redirect_to admin_youtubes_path
	end

  def youtube_params
    params.require(:youtube).permit(:title, :youtube_code, :category_ids => [])
  end
	
end
