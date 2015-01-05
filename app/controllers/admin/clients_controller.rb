class Admin::ClientsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :client_params, :only =>  :create
  authorize_resource
  
  layout "admin/admin"
  
  def index  
      @clients = Client.page(params[:page]).per(50)
      @title = "Client"
  end
  
  def new 
    @client = Client.new
    @title = "New Client"
    render :layout => false
  end
  
  def create 
    @client = Client.new(client_params)
    if @client.save 
      flash[:success]= "Successfully created Client."
          redirect_to admin_clients_path
    else
      render :action => 'new' 
      @title = "New Client"
    end
  end
  
  def edit
    @client = Client.find(params[:id])
    render :layout => false
  end
  
  def update 
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
      flash[:success]= "Successfully updated frequently asked question."
        redirect_to admin_clients_path
    else
      render 'edit'
      @title = "New Client"
    end
  end
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to admin_clients_path
  end

  def client_params
    params.require(:client).permit!
  end
end
