class BannersController < ApplicationController

  def show
    @banner = Banner.find_by_secure_url(params[:id])
  end
end
