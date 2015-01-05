class Admin::TopicsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :topic_params, :only => :create
  authorize_resource
  layout 'admin/admin'
  
  def index
    @topics = Topic.all 
    @title = "Topics"
  end
  
  def show
    @topic = Topic.friendly.find(params[:id])
    @title = @topic.name
    respond_to do |format|
      format.html
      format.csv {render text: @topic.to_csv(@topic)}
      format.xls
      format.xlsx
    end
  end
  
  def new
    @topic = Topic.new
    @clients = Client.all
    render :layout => false
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save 
      flash[:success]= "Successfully created topic."
    end
    respond_to do |format|
      if @topic.save
            format.html {redirect_to admin_topics_path}
        format.js
      else
        @title = "New Topic"
        format.html { render :action => :new }
        format.js
      end
    end 
  end

  def edit
    @topic = Topic.friendly.find(params[:id])
    @title = @topic.name
    @clients = Client.all
    render :layout => false
  end 
  
  def update 
    @topic = Topic.friendly.find(params[:id])
    if @topic.update_attributes(topic_params)
      flash[:success]= "Successfully updated topic."
      redirect_to admin_topics_path
    else
      render :action => 'edit'
      @title = "Edit Topic"
    end
  end


  def destroy
    @topic = Topic.friendly.find(params[:id])
    @topic.destroy
    redirect_to admin_topics_path
  end

  def topic_params
    params.require(:topic).permit(:name, :client_id)
  end

  def import
    Topic.get_user(params[:user])
    Topic.import(params[:file])
    redirect_to admin_topics_path, notice: "Campaign imported"
  end

  def keywords
    Topic.keywords(params[:file])
    redirect_to admin_topics_path, notice: "Keywords imported"
  end

end
