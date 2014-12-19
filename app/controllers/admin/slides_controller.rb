class Admin::SlidesController < ApplicationController

	before_filter :authenticate_user!
	before_filter :slide_params, :only => :create
	load_and_authorize_resource
	layout "admin/admin"
	
	def index  
	    if params[:slide].present?
		    @slide = Slide.find(params[:slide])
		    render :action => 'edit'
	    else
	      @slides = Slide.page(params[:page]).per(50)
	      @title = "Sliders"
	    end
	end
	
	def new 
		@title = "New slide"
		@slider = Slider.find(params[:slider_id])
		@images = Image.all
	end
	
	def create 
		if params[:slide][:image_id].blank?
			flash[:error]= "You need to choose an image when creating a slide."
			redirect_to new_admin_slider_slide_path(params[:slide][:slider_id])
			@title = "New slide"
		else
			if @slide.save 

				update_css_js(@slide)

				flash[:success]= "Successfully slide."
	      redirect_to admin_sliders_path
			else
				redirect_to new_admin_slider_slide_path(params[:slide][:slider_id])
				@title = "New slide"
			end
		end
	end
	
	def edit
		@slider = Slider.find(@slide.slider_id)
		@images = Image.all
	end
	
	def update 

		if @slide.update_attributes(slide_params)
			flash[:success]= "Successfully slide."
				redirect_to admin_slider_path(@slide.slider_id)

				update_css_js(@slide)
				
		else
			redirect_to edit_admin_slider_slide_path(@slide.slider_id, @slide)
			@title = "New slide"
		end
	end
	
	def destroy
		@slide.destroy
		redirect_to admin_slider_path @slide.slider_id
	end

	def update_css_js(slide)
		css = Rails.public_path + "/slider#{slide.slider_id}.css"
		js = Rails.public_path + "/slider#{slide.slider_id}.js"
		if File.exists?(css) || File.exists?(js)
			FileUtils.rm(css)
			FileUtils.rm(js)
		end	
	end

	def slide_params
		params.require(:slide).permit!
	end
end
