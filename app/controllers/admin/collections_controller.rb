class Admin::CollectionsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :collection_params, :only => :create
  authorize_resource
  layout 'admin/admin'

  def index
    @collections = Collection.order("id DESC")
  end

  def new 
    @collection = Collection.new()
    @title = "New collecton"
    get_asset_type(params[:asset])
  end
  
  def create 
    @collection = Collection.new(collection_params)
    if @collection.save 
      flash[:success]= "Successfully created collection."
          redirect_to admin_collections_path
    else
      render :action => 'new' 
      @title = "New collection"
    end
  end
  
  def edit
    @collection = Collection.find(params[:id])
    @title = @collection.title
    get_asset_type(params[:asset])
  end
  
  def update 
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(collection_params)
      flash[:success]= "Successfully updated collection."
        redirect_to admin_collections_path
    else
      render 'edit'
      @title = "New collection"
    end
  end
  
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    redirect_to admin_collections_path
  end

  private

  def get_asset_type(asset)
    case asset
    when 'ic'
      @image = true

    when 'dc'
      @document = true
   
    when 'uc'
      @user = true
    
    when 'ac'
      @audio = true
    
    when 'vc'
      @video = true
    end
  end

  def collection_params
    params.require(:collection).permit!
  end

end
