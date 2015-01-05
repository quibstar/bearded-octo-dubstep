class CopiesController < ApplicationController

  respond_to :html, :js  
  
  def new
    @copy = Copy.new
    @review = Review.find_by_url(params[:rev_id])
    @group = Group.find(params[:group_id])
    
    if params[:copy_id]
      @alt_copy = Copy.find(params[:copy_id]) 
    end
    
    render :layout => false
  end

  def create
    @copy = Copy.new(copy_params)
    if @copy.save 
      flash[:success]= "Successfully created copy."
      redirect_to review_path(params[:url])
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to review_path(params[:url])
    end 
  end

  def copy_params
    params.require(:copy).permit!
  end

end
