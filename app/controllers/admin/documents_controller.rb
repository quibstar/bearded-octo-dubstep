class Admin::DocumentsController < ApplicationController
  
  	before_filter :authenticate_user!, :except => [:show]
  	before_filter :doc_params, :only => :create
   	layout 'admin/admin'

	def index 
	  if params[:document].present?
	    @document = Document.find(params[:document])
	    render :action => 'edit'
    else
		  @documents = Document.order("title").page(params[:page]).per(20) 
	  end
	end
	
	def new 
		@document = Document.new
		render :layout => false
	end
	
	
	def create 
	  @document = Document.new(doc_params)
	    if @document.save
	      flash[:success]= "Successfully created document."
	      redirect_to admin_documents_path
	    else
	      @title = "New Document"
	      render :action => 'new' 
	    end
	end
	
	def edit
		@document = Document.find(params[:id])
		render :layout => false
	end
	
	def update 
	  	params[:document][:category_ids] ||= []
		@document = Document.find(params[:id])
	    if @document.update_attributes(doc_params)
	      flash[:success] = "Successfully updated document."
	      redirect_to admin_documents_path
      else
        flash[:error] = "There was an error please try again."
        redirect_to admin_documents_path
	    end
	    
	end
	
	def destroy 
		document = Document.find(params[:id])

		document.asset_categories.each do |ac|
			ac.destroy
		end

		document.delete
		flash[:success] = "Successfully removed document."
		redirect_to admin_documents_path
	end
	
	def featured_image
	 	@document = Document.find(params[:id])
		render :layout => false
	end
	

	def doc_params
		params.require(:document).permit(:title, :document, :description, :image_id, :document_id, :image_size, :asset_categories ,:category_ids => [])
	end
end
