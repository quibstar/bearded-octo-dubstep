class Admin::FaqsController < ApplicationController

	before_filter :authenticate_user!
	before_filter :faq_params, :only =>  :create
	authorize_resource
	
	layout "admin/admin"
	
	def index  
	    if params[:faq].present?
		    @faq = Faq.find(params[:faq])
		    render :action => 'edit'
	    else
	      @faqs = Faq.page(params[:page]).per(50)
	      @title = "Frequently Asked Question"
	    end
	end
	
	def new 
		@faq = Faq.new
		render :layout => false
		@title = "New Faq"
	end
	
	def create 
		@faq = Faq.new(faq_params)
		if @faq.save 
			flash[:success]= "Successfully created Frequently Asked Question."
      		redirect_to admin_faqs_path
		else
			render :action => 'new' 
			@title = "New Frequently Asked Question"
		end
	end
	
	def edit
		@faq = Faq.find(params[:id])
		render :layout => false
	end
	
	def update 
		@faq = Faq.find(params[:id])
		if @faq.update_attributes(faq_params)
			flash[:success]= "Successfully updated frequently asked question."
				redirect_to admin_faqs_path
		else
			render 'edit'
			@title = "New Frequently Asked Question"
		end
	end
	
	def destroy
		@faq = Faq.find(params[:id])
		@faq.destroy
		redirect_to admin_faqs_path
	end

	def faq_params
		params.require(:faq).permit(:question, :answer)
	end
end
