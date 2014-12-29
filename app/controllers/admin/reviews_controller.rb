class Admin::ReviewsController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource
  layout 'admin/admin'

  def create
    users = params[:users].split( /\r?\n/ )
    puts users
    users.each do |u|
      review = Review.new
      review.user = u 
      review.topic_id = params[:topic_id]
      review.save
      ReviewMailer.send_review_link(review.url, review.user).deliver
    end
    flash[:success]= "Successfully send out review notices."
    redirect_to admin_topic_path(params[:topic_id])
  end


end
