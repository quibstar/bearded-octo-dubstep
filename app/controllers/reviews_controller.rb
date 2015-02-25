class ReviewsController < ApplicationController


  def show
    @review = Review.find_by_url(params[:id])
    @topic = Topic.find(@review.topic_id)
  end
end
