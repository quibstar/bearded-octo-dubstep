class SearchController < ApplicationController

  def index
    #set up pg_search
    @results = PgSearch.multisearch(params[:search]).page(params[:page])
  end
  

end