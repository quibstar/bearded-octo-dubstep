class Admin::RewritesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :rewrite_params, :only => :create
  load_and_authorize_resource
  layout 'admin/admin'

  def index
    @rewrites = Rewrite.order('id DESC')  
  end

  def edit
    @rewrite = Rewrite.find(params[:id])
    render :layout => false
  end

  def new
    @rewrite = Rewrite.new
    render :layout => false
  end

  def create
    if !new_rewrite_info
      redirect_to admin_rewrites_path
    else
      @rewrite.request_path = params[:rewrite][:request_path].parameterize
      if @rewrite.save
        flash[:success]= "URL Rewrite created."
        redirect_to admin_rewrites_path
      else
        flash[:error]= "Error: URL Rewrite could not be written, Please try again."
        redirect_to admin_rewrites_path
        @title = "New URL Rewrite"
      end
    end
  end

  def update
    if !update_rewrite_info 
      redirect_to admin_rewrites_path
    else
      @rewrite.request_path = params[:rewrite][:request_path].parameterize
      if @rewrite.update_attributes(rewrite_params)
        flash[:success]= "Successfully updated URL Rewrite."
        redirect_to admin_rewrites_path
      else
        flash[:error]= "Error: URL Rewrite could not be written, Please try again."
        redirect_to admin_rewrites_path
        @title = "Edit URL Rewrite"
      end
    end
  end

  def destroy
      @rewrite.destroy
      flash[:success] = "Successfully removed URl Rewrite."
      redirect_to admin_rewrites_path 
  end

  def new_rewrite_info
    if params[:rewrite_for] == 'page'
      page = Page.find_by_id(params[:rewrite][:page_id])
      if page
        @rewrite.target_path = page.url_path
        @rewrite.post_id = nil
        return true
      else
        return false
      end
    elsif params[:rewrite_for] == 'post'
      post = Post.find_by_id(params[:rewrite][:post_id])
      if post 
        @rewrite.target_path = post.slug
        @rewrite.page_id = nil
        return true
      else
        return false
      end
    else
      return false
      flash[:error]= "Error: Getting rewrite info"
    end
  end

  def update_rewrite_info
    if params[:rewrite][:page_id].present?
      page = Page.find_by_id(params[:rewrite][:page_id])
      if page
        @rewrite.target_path = page.url_path
        @rewrite.post_id = nil
        return true
      else
        return false
      end
    elsif params[:rewrite][:post_id].present?
      post = Post.find_by_id(params[:rewrite][:post_id])
      if post 
        @rewrite.target_path = post.slug
        @rewrite.page_id = nil
        return true
      else
        return false
      end
    else
      return false
      flash[:error]= "Error: Getting rewrite info"
    end
  end

  def rewrite_params
    params.require(:rewrite).permit!
  end

end