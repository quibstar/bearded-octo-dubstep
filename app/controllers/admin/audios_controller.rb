class Admin::AudiosController < ApplicationController

	before_filter :authenticate_user!, :except => [:show]
	before_filter :audio_params, :only => :create
	layout 'admin/admin'

	def index 
		@audios = Audio.all 
	end
	
	def new 
		@audio = Audio.new
		@title = "New Audio"
		render :layout => false
	end
	
	
	def create 
	  @audio = Audio.new(audio_params)
	    if @audio.save
	      flash[:success]= "Successfully created audio."
	      redirect_to admin_audios_path
	    else
	      @title = "New Audio"
	      render :action => 'new' 
	    end
	end
	
	def edit
		@audio = Audio.find(params[:id])
		render :layout => false	
	end
	
	def update 
		params[:audio][:category_ids] ||= []
		@audio = Audio.find(params[:id])
	      if @audio.update_attributes(audio_params)
	      flash[:success] = "Successfully updated audio."
	      redirect_to admin_audios_path
	    end
	end
	
	def destroy 
	  audio = Audio.find(params[:id])

	  audio.asset_categories.each do |ac|
			ac.destroy
		end
		
		audio.destroy
		flash[:success] = "Successfully removed audio."
		redirect_to admin_audios_path
	end
	
	def featured_image
	 	@audio = Audio.find(params[:id])
		render :layout => false
	end

	def audio_params
		params.require(:audio).permit(:artist, :title, :description,:audio, :category_ids => [])
	end

end
