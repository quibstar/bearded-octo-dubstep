class Admin::ReviewsController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource
  layout 'admin/admin'

  # def create
  #   users = params[:users].split( /\r?\n/ )
  #   users.each do |u|
  #     review = Review.new
  #     review.user = u 
  #     review.client_id = params[:topic_id]
  #     review.save
  #     ReviewMailer.send_review_link(review.url, review.user, current_user).deliver
  #   end

  #   flash[:success]= "Successfully send out review notices."
  #   redirect_to admin_client_path(params[:topic_id])
  # end


  def new
    @review = Review.new
    @client = Client.find(params[:client_id])
    render :layout => false
  end

  def create
    @review = Review.new(review_params)
    if @review.save 
      flash[:success]= "Successfully created review."
      redirect_to admin_clients_path(@review.client_id)
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to admin_clients_path
    end 
  end

  def edit
    @review = Review.find(params[:id])
    @client = Client.find(@review.client_id)
    render :layout => false
  end 
  
  def update 
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success]= "Successfully updated review."
      redirect_to admin_clients_path(anchor: "client-#{@review.client_id}")
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to admin_clients_path(anchor: "client-#{@review.client_id}")
    end
  end

  def destroy
    @review = Review.find(params[:id])
    redirect_to admin_clients_path
    @review.destroy
  end

  def review_params
    params.require(:review).permit!
  end
end
