class Admin::ImagesController < ApplicationController

	before_filter :authenticate_user!
	before_filter :image_params, :only => :create
	authorize_resource

	layout 'admin/admin'
	
	def index
		if params[:image].present?
		    @image = Image.find(params[:image])
		    render :action => 'edit'
	    else
	    	@images = Image.order(:title) 
			@title = "Images"
		end
	end
	
	def show
		@title = @image.title
	end
	
	def new
		@image = Image.new
		render :layout => false
	end

	def create
			@image = Image.new(image_params)
	    if @image.save
	      	if params[:image][:asset] == 'document'
		     	redirect_to admin_documents_path
		     	flash[:success] = "Successfully updated document image."
		     	
		     elsif params[:image][:asset] == 'audio'
		     	redirect_to edit_admin_audio_path(params[:image][:asset_id])
		     	flash[:success] = "Successfully updated audio image."
		     	
		     elsif params[:image][:asset] == 'video'
		     	redirect_to edit_admin_video_path(params[:image][:asset_id])
		     	flash[:success] = "Successfully updated video image."
		     			     	
		      elsif params[:image][:asset] == 'post'
		     	post = Post.find(params[:image][:asset_id])
		     	redirect_to edit_admin_publication_post_path(post.publication_id,params[:image][:asset_id])
		     	flash[:success] = "Successfully uploaded Post image."		     	
		     else
		     	flash[:success] = "Successfully uploaded image."
		     	respond_to do |format|
      				format.html {redirect_to admin_images_path} 
      				format.js
    			end 
	      end
	    else
	      @title = "New Image"
	      render :action => 'new' 
	    end
	end

	def edit
		@image = Image.find(params[:id])
		@title = @image.title
		render :layout => false
	end	
	
	def update 
		params[:image][:category_ids] ||= []
		@image = Image.find(params[:id])
	      if @image.update_attributes(image_params)
		     if params[:image][:asset] == 'document'
		     	redirect_to edit_admin_document_path(params[:image][:asset_id])
		     	flash[:success] = "Successfully updated document image."
		     	
		     elsif params[:image][:asset] == 'audio'
		     	redirect_to edit_admin_audio_path(params[:image][:asset_id])
		     	flash[:success] = "Successfully updated audio image."
		     	
		     elsif params[:image][:asset] == 'video'
		     	redirect_to edit_admin_video_path(params[:image][:asset_id])
		     	flash[:success] = "Successfully updated video image."
		     	
		     	
		     elsif params[:image][:asset] == 'post'
		     	post = Post.find(params[:image][:asset_id])
		     	redirect_to edit_admin_publication_post_path(post.publication_id,params[:image][:asset_id])
		     	flash[:success] = "Successfully updated Post image."

		     else 
		      flash[:success] = "Successfully updated image."
		      respond_to do |format|
      				format.html {redirect_to admin_images_path()} 
      				format.js
    			end
	      	 end
	      else
			render :action => 'edit'
			@title = "Edit Image"
	    end
	end

	def destroy
		@image.destroy
		redirect_to admin_images_path
	end
	
	
	def featured_image
	 	@publication = Publication.find(params[:publication_id])
	 	@post = Post.find(params[:post_id])
	 	@image = Image.find(params[:id])
		render :layout => false
	end

	def image_params
		params.require(:image).permit(:title,:image, :caption, :description, :image_cache, :remove_image, :asset, :asset_id, :publication_id, :image_size, :image_id, :post_id,:category_ids => [])
	end
end
