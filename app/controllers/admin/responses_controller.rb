class Admin::ResponsesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :response_params, :only => :create
  load_and_authorize_resource
  layout 'admin/admin'

  def index
    @response = Response.order(:id)
    @title = "Responses"
  end
  
  def new
    @response = Response.new
    render :layout => false
  end
  
  def create 
    @response = Response.new(response_params)
    if @response.save 
      flash[:success]= "Response has been created."
      redirect_to admin_notes_path
    else
      @title = "New Response"
      render :action => :new 
    end
  end
  
  def edit
    @response = Response.find(params[:id])
    @title = "Update Response"
    render :layout => false
  end
  
  def update
    @response = Response.find(params[:id])
    if @response.update_attributes(response_params)
      flash[:success]= "Successfully updated response."
      redirect_to admin_notes_path()
      else
        render :action => 'edit'
        @title = "Edit Response"
      end
  end
  
  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    flash[:success] = "Successfully removed response."
    redirect_to admin_notes_path
  end

  def response_params
    params.require(:response).permit!
  end
end
