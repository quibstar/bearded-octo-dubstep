class FlashMediaController < ApplicationController

  def show
    @flash_review = FlashReview.find_by_secure_url(params[:id])
  end
end
