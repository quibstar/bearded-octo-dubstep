class Admin::SwfsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  before_filter :swf_params, :only => :create
  layout 'admin/admin'

  def index 
    @swfs = Swf.all 
  end
  
  def new 
    @swf = Swf.new
    @title = "New Swf"
    @clients = Client.all

    if params[:flash_review]
      @flash_review = FlashReview.find(params[:flash_review])
    end

    render :layout => false
  end
  
  def show
    @swf = Swf.find(params[:id])
    @title = @swf.title
    render :layout => false
  end
  
  def create 
    @swf = Swf.new(swf_params)
      if @swf.save
        flash[:success]= "Successfully created flash (.swf)"

        if swf_params[:flash_review]

          @flash_review = FlashReview.find(swf_params[:flash_review])
          @flash_review.swfs << @swf
          @flash_review.save
          redirect_to admin_flash_reviews_path
        else
          redirect_to admin_swfs_path
        end

      else
        @title = "New Swf"
        render :action => 'new' 
      end
  end
  
  def edit
    @swf = Swf.find(params[:id])
    @title = @swf.title
    @clients = Client.all
    render :layout => false 
  end
  
  def update 
    @swf = Swf.find(params[:id])
    if @swf.update_attributes(swf_params)
      flash[:success] = "Successfully updated flash (.swf)"
      redirect_to admin_swfs_path
    end
  end
  
  def destroy 
    swf = Swf.find(params[:id])
    swf.destroy
    flash[:success] = "Successfully removed flash (.swf)"
    redirect_to admin_swfs_path
  end
  
  def featured_image
    @swf = Swf.find(params[:id])
    render :layout => false
  end

  def swf_params
    params.require(:swf).permit!
  end

end

