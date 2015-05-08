class Admin::KeywordsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :keyword_params, :only =>  :create
  authorize_resource
  
  layout "admin/admin"
  
  
  def new 
    @keyword = Keyword.new
    @group = Group.find(params[:group_id])
    render :layout => false
    @title = "New keyword"
  end
  
  def create 
    @keyword = Keyword.new(keyword_params)
    @group = Group.find(@keyword.group_id)
    if @keyword.save 
      flash[:success]= "Successfully created keyword."
          redirect_to admin_topic_path(@group.topic_id, anchor: "group-#{@group.id}")
    else
      render :action => 'new' 
      @title = "New keyword"
    end
  end
  
  def edit
    @keyword = Keyword.find(params[:id])

    render :layout => false
  end
  
  def update 
    @keyword = Keyword.find(params[:id])
    @group = Group.find(@keyword.group_id)
    if @keyword.update_attributes(keyword_params)
      flash[:success]= "Successfully updated keyword."
        redirect_to admin_topic_path(@group.topic_id, anchor: "group-#{@group.id}")
    else
      render 'edit'
      @title = "New keyword"
    end
  end
  
  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy
    redirect_to admin_keywords_path
  end

  def keyword_params
    params.require(:keyword).permit!
  end
end

