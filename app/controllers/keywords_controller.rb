class KeywordsController < ApplicationController

  before_filter :keyword_params, :only =>  :create
 
  def new 
    @keyword = Keyword.new
    @group = Group.find(params[:group_id])
    @review = Review.find_by_url(params[:review_url])

    render :layout => false
    @title = "New keyword"
  end
  
  def create 
    @keyword = Keyword.new(keyword_params)
    @group = Group.find(@keyword.group_id)
    @review = Review.find_by_url(params[:review_url])

    if @keyword.save 
      flash[:success]= "Successfully created keyword."
      redirect_to review_path(params[:keyword][:review_url])
    else
      render :action => 'new' 
      @title = "New keyword"
    end
  end
  
  def edit
    @keyword = Keyword.find(params[:id])
    @review = Review.find_by_url(params[:review_url])
    puts @review
    render :layout => false
  end
  
  def update 
    puts params[:review_url]
    @keyword = Keyword.find(params[:id])

    if @keyword.update_attributes(keyword_params)
      flash[:success]= "Successfully updated keyword."
      redirect_to review_path(params[:keyword][:review_url])
    else
      render 'edit'
      @title = "New keyword"
    end
  end

  def keyword_params
    params.require(:keyword).permit!
  end
end