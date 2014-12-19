class Admin::SlidersController < ApplicationController
	
	before_filter :authenticate_user!
	before_filter :slider_params, :only => :create
	load_and_authorize_resource
	layout "admin/admin"
	
	def index  
	    if params[:slider].present?
		    @slider = Slider.find(params[:slider])
		    render :action => 'edit'
	    else
	      @sliders = Slider.page(params[:page]).per(50)
	      @title = "Sliders"
	    end
	end
	
	def show
		@slider.title.capitalize
		@slides = @slider.slides.order('id ASC')
	end

	def new 
		@title = "New slider"
	end
	
	def create 
		if @slider.save 
			flash[:success]= "Successfully slider."
      		redirect_to admin_sliders_path
		else
			render :action => 'new' 
			@title = "New slider"
		end
	end
	
	def edit
	end
	
	def update 
		if @slider.update_attributes(slider_params)
			flash[:success]= "Successfully slider."
				redirect_to edit_admin_slider_path(@slider)

				css = Rails.public_path + "/slider#{@slider.id}.css"
				js = Rails.public_path + "/slider#{@slider.id}.js"
				if File.exists?(css) || File.exists?(js)
					FileUtils.rm(css)
					FileUtils.rm(js)
				end

		else
			render 'edit'
			@title = "New slider"
		end
	end
	
	def destroy
		@slider.destroy
		page = Page.where(:slider_id => @slider)
		page.each do |p|
			p.update_attributes(:slider_id => '')
		end
		redirect_to admin_sliders_path
	end

	def slider_params
		params.require(:slider).permit!
	end
end
