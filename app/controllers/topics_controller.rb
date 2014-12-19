class TopicsController < ApplicationController

  def show

    # possible
    # @topic_slug  = Review.find_by_hash(hash_id)
    # @topic = Topic.friendly.find(topic_slug)

    @topic = Topic.friendly.find(params[:id])
    @title = @topic.name
  end

end
