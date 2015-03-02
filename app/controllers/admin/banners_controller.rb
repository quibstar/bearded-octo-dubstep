class Admin::BannersController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  before_filter :banner_params, :only => :create
  layout 'admin/admin'

  def index 
    @banners = Banner.all 
  end
  
  def new 
    @banner = Banner.new
    @title = "New Banner"
    @clients = Client.all
    @swfs = Swf.all
  end
  
  def show
    @banner = Banner.find(params[:id])
    @title = @banner.title
  end
  
  def create 
    @banner = Banner.new(banner_params)
      if @banner.save
        flash[:success]= "Successfully created banner"
        redirect_to admin_banners_path
      else
        @title = "New Banner"
        render :action => 'new' 
      end
  end
  
  def edit
    @banner = Banner.find(params[:id])
    @clients = Client.all
    @swfs = Swf.all
  end
  
  def update 
    if banner_params[:users]
      # using user to send email
      users = banner_params[:users].split( /\r?\n/ )
      @banner = Banner.find(banner_params[:id])
      users.each do |user|
        ReviewMailer.send_banner_link(@banner.secure_url, user, current_user).deliver
      end
      flash[:success]= "Successfully send out review notices."
      redirect_to admin_banners_path
    else
      @banner = Banner.find(params[:id])
      if @banner.update_attributes(banner_params)
        flash[:success] = "Successfully updated banner"
        redirect_to admin_banners_path
      end
    end
  end
  
  def destroy 
    banner = Banner.find(params[:id])
    banner.destroy
    flash[:success] = "Successfully removed flash (.banner)"
    redirect_to admin_banners_path
  end
  
  def featured_image
    @banner = Banner.find(params[:id])
    render :layout => false
  end

  def banner_params
    params.require(:banner).permit!
  end

end
