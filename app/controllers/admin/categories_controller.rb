class Admin::CategoriesController < ApplicationController

	before_filter :authenticate_user!
	before_filter :category_params, :only => :create
	authorize_resource
	layout 'admin/admin'
	
	def index
	    if params[:category].present?
		    @category = Category.find(params[:category])
		    render :action => 'edit'
	    else
	      @categories = Category.order(:name).page(params[:page]).per(50) 
	      @title = "Categories"
	    end
	end
	
	def show
		@category = Category.where(:slug => params[:id]).first
		@title = @category.name
	end
	
	def new
		@category = Category.new
		render :layout => false
	end

	def create
		@category = Category.new(category_params)
		if @category.save 
			flash[:success]= "Successfully created category."
		end
		respond_to do |format|
			if @category.save
      			format.html {redirect_to admin_categories_path}
				format.js
			else
				@title = "New Category"
				format.html { render :action => :new }
				format.js
			end
		end 
	end

	def edit
		@category = Category.friendly.find(params[:id])
		render :layout => false
		@title = @category.name
	end	
	
	def update 
		Rails.logger.debug(category_params)
		@category = Category.friendly.find(params[:id])
		if @category.update_attributes(category_params)
			flash[:success]= "Successfully updated category."
			redirect_to admin_categories_path
    else
      render :action => 'edit'
      @title = "Edit Category"
    end
	end


	def destroy
		@category = Category.friendly.find(params[:id])
		@category.destroy
		redirect_to admin_categories_path
	end

	def category_params
		params.require(:category).permit(:name, :image, :document, :audio, :user, :post, :video, :youtube)
	end
end
