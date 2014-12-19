class Admin::LinksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :link_params, :only => :create
  authorize_resource
  layout 'admin/admin'
  
  def index
    @links = Link.all
    @title = "Links"
  end
  
  def new
    @link = Link.new
    render :layout => false
  end
  
  def create
    @link = Link.new(link_params) 
    if @link.save 
      flash[:success]= "Link has been submitted."
      redirect_to admin_links_path
    else
      @title = "New Link"
      render :action => :new 
    end
  end
  
  def edit
    @link = Link.find(params[:id])
    @title = "Update Link"
    render :layout => false
  end
  
  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      flash[:success]= "Successfully updated link."
      redirect_to admin_links_path()
      else
        render :action => 'edit'
        @title = "Edit Link"
      end
  end
  
  def destroy
    @link = Link.find(params[:id])
    @link.asset_categories.each do |ac|
      ac.destroy
    end
    @link.destroy
    flash[:success] = "Successfully removed link."
    redirect_to admin_links_path
  end

  def link_params
    params.require(:link).permit(:link, :link_title, :new_window)
  end
end
