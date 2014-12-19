class Admin::TestimonialsController < ApplicationController

	before_filter :authenticate_user!
  before_filter :testimonial_params, :only =>  :create
	authorize_resource

	layout 'admin/admin'
	
  def index
    if params[:testimonial].present?
	    @testimonial = Testimonial.find(params[:testimonial])
	    render :action => 'edit'
    else
      @testimonials = Testimonial.where(true)
    end
  end

  def new
    @testimonial = Testimonial.new
    render :layout => false
  end
  
	def create 
    @testimonial = Testimonial.new(testimonial_params)
		if @testimonial.save 
			flash[:success]= "Testimonial has been submitted."
			#create function to notify author
      redirect_to admin_testimonials_path()
		else
			render 'new' 
			flash[:error]= "There was an issue with your testimonial submission. Please try again."
			@title = "New Testimonial"
		end
	end
	
	def edit
    @testimonial = Testimonial.find(params[:id])
		@title = "Update Testimonial"
    render :layout => false
	end
	
	def update 
      @testimonial = Testimonial.find(params[:id])
			if @testimonial.update_attributes(testimonial_params)
				flash[:success]= "Successfully updated testimonial."
        redirect_to admin_testimonials_path()
			else
				render :action => 'edit'
				@title = "New Testimonial"
			end
	end
	
	def destroy 
      @testimonial = Testimonial.find(params[:id])
    	@testimonial.destroy
    	flash[:success] = "Successfully removed testimonial."
    	redirect_to admin_testimonials_path
	end

  def testimonial_params
    params.require(:testimonial).permit(:title, :testimonial, :author, :position, :company)
  end
end
