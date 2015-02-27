class Admin::FlashReviewsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  before_filter :flash_review_params, :only => :create
  layout 'admin/admin'

  def index 
    @flash_reviews = FlashReview.all 
  end
  
  def new 
    @flash_review = FlashReview.new
    @title = "New FlashReview"
    @clients = Client.all
    @swfs = Swf.all
  end
  
  def show
    @flash_review = FlashReview.find(params[:id])
    @title = @flash_review.title
  end
  
  def create 
    @flash_review = FlashReview.new(flash_review_params)
      if @flash_review.save
        flash[:success]= "Successfully created flash review)"
        redirect_to admin_flash_reviews_path
      else
        @title = "New FlashReview"
        render :action => 'new' 
      end
  end
  
  def edit
    @flash_review = FlashReview.find(params[:id])
    @clients = Client.all
    @swfs = Swf.all
  end
  
  def update 
    if flash_review_params[:users]
      # using user to send email
      users = flash_review_params[:users].split( /\r?\n/ )
      @flash_review = FlashReview.find(flash_review_params[:id])
      users.each do |user|
        ReviewMailer.send_flash_review_link(@flash_review.secure_url, user, current_user).deliver
      end
      flash[:success]= "Successfully send out review notices."
      redirect_to admin_flash_reviews_path
    else
      @flash_review = FlashReview.find(params[:id])
      if @flash_review.update_attributes(flash_review_params)
        flash[:success] = "Successfully updated flash review"
        redirect_to admin_flash_reviews_path
      end
    end
  end
  
  def destroy 
    flash_review = FlashReview.find(params[:id])
    flash_review.destroy
    flash[:success] = "Successfully removed flash (.flash_review)"
    redirect_to admin_flash_reviews_path
  end

  # def email_client
  #   users = params[:users].split( /\r?\n/ )
  #   @flash_review = FlashReview.find(params[:id])
  #   users.each do |u|
  #     ReviewMailer.send_flash_review_link(@flash_review.secure_url, review.user, current_user).deliver
  #   end
  #   flash[:success]= "Successfully send out review notices."
  #   redirect_to admin_flash_reviews_path
  # end
  
  def featured_image
    @flash_review = FlashReview.find(params[:id])
    render :layout => false
  end

  def flash_review_params
    params.require(:flash_review).permit!
  end

end


