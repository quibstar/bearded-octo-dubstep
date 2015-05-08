class ReviewsController < ApplicationController


  def show
    @review = Review.find_by_url(params[:id])
    if @review.topic_id
      @topic = Topic.find(@review.topic_id)
    else
      @client = Client.find(@review.client_id)
    end
  end
end
