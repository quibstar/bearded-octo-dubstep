class Admin::CopiesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :copy_params, :only => :create
  authorize_resource
  layout 'admin/admin'

  def new
    @copy = Copy.new
    @group = Group.find(params[:group_id])
    render :layout => false
  end

  def create
    @copy = Copy.new(copy_params)
    if @copy.save 
      flash[:success]= "Successfully created copy."
      redirect_to admin_topic_path(@copy.group.topic_id)
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to admin_topic_path(@copy.group.topic_id)
    end 
  end

  def edit
    @copy = Copy.find(params[:id])
    @group = Group.find(params[:group_id])
    render :layout => false
  end 
  
  def update 
    @copy = Copy.find(params[:id])
    if @copy.update_attributes(copy_params)
      flash[:success]= "Successfully updated copy."
      redirect_to admin_topic_path(@copy.group.topic_id)
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to admin_topic_path(@copy.group.topic_id)
    end
  end


  def destroy
    @copy = Copy.find(params[:id])
    redirect_to admin_topic_path(@copy.group.topic_id)
    @copy.destroy
    
  end

  def copy_params
    params.require(:copy).permit!
  end
end
