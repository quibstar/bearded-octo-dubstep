class Admin::SettingsController < ApplicationController

	before_filter :authenticate_user!
  before_filter :setting_params, :only => :create
	load_and_authorize_resource
  layout 'admin/admin'

  PUBLIC = Rails.root.join("public")
   
   def index
      @title = "Site Settings"
      @setting = Setting.first
      @states = State.all
      @robots_txt = File.read("#{PUBLIC}/robots.txt")
   end

  def new
    @title = "New Setting"
    @states = State.all
  end
  def create
    @setting = Setting.new(setting_params)
    if @setting.save
      flash[:success]= "Successfully created setting."
      redirect_to admin_settings_path(params[:setting][:page_id]) 
    else
      @title = "New Setting"
      render :action => 'new' 
    end
  end
  
  def edit
    @title = 'Edit Settings'
    @states = State.all
  end
  def update
    if params[:setting][:robots]
      File.open("#{PUBLIC}/robots.txt", 'w') {|f| f.write(params[:setting][:robots]) }
      flash[:success]= "Successfully updated robots.txt file."
      redirect_to admin_settings_path(params[:setting][:page_id])
    else
     @setting.update_attributes(setting_params)
      flash[:success] = "Successfully updated page."
      redirect_to admin_settings_path(params[:setting][:page_id])
    end
  end
  
  def destroy
    @setting.destroy
    flash[:success] = "Successfully removed setting."
    redirect_to admin_settings_path(params[:page_id])
  end
  
  def update_robots
    File.open("#{PUBLIC}/robots.txt", 'w') {|f| f.write(params[:css]) }
    flash[:success]= "Successfully updated css."
    redirect_to admin_settings_path
  end

  def setting_params
    params.require(:setting).permit!
  end
end
