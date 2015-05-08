class Admin::GroupsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :group_params, :only => :create
  authorize_resource
  layout 'admin/admin'
  
  def new
    @topic = Topic.friendly.find(params[:topic_id])
    @group = Group.new
    render :layout => false
  end

  def show
    @group = Group.find(params[:id])
    @title = ""
    @group.keywords_only = params[:keywords_only]
    puts @group.keywords_only
    fileName = "DDM Ad Review -" + @group.name 
    respond_to do |format|
      format.xls
      format.xlsx{response.headers['Content-Disposition'] = "attachment; filename='" + fileName[0..30] + ".xlsx'"}
    end
  end

  def create
    @group = Group.new(group_params)
    if @group.save 
      flash[:success]= "Successfully created group."
      redirect_to admin_topic_path(@group.topic_id)
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to admin_topic_path(@group.topic_id)
    end 
  end

  def edit
    @group = Group.find(params[:id])
    @title = @group.name
    @topic = Topic.friendly.find(params[:topic_id])
    render :layout => false
  end 
  
  def update 
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success]= "Successfully updated group."
      redirect_to admin_topic_path(@group.topic_id, anchor: "group-#{@group.id}")
    else
      flash[:success]= "Something went wrong please try again."
      redirect_to admin_topic_path(@group.topic_id, anchor: "group-#{@group.id}")
    end
  end


  def destroy
    @group = Group.find(params[:id])
    redirect_to admin_topic_path(@group.topic_id)
    @group.destroy
  end

  def group_params
    params.require(:group).permit!
  end
end
