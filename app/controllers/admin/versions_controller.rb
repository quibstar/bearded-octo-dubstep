class Admin::VersionsController < ApplicationController

  before_filter :authenticate_user!
  layout 'admin/admin'

  def index
    @versions = Version.order('id DESC')  
  end

  def show
    @record = Version.find(params[:id])
    @version = @record.item_type.constantize.find_by_id(@record.item_id)
  end

  # def restore
  #   if params[:undo] =='Section'
  #     section = Section.find(params[:vid])
  #     save_previous_version(section)
  #   end
  #   if params[:undo] =='Content'
  #     content = Content.find(params[:vid])
  #     save_previous_version(content)
  #   end
  #   if params[:undo] =='Page'
  #     page = Page.find(params[:vid])
  #     save_previous_version(page)
  #   end
  #   if params[:undo] =='Post'
  #     post = Post.find(params[:vid])
  #     save_previous_version(post)
  #   end
  #   if params[:undo] =='Publication'
  #     publication = Publication.find(params[:vid])
  #     save_previous_version(publication)
  #   end
  #   if params[:undo] =='User'
  #     user = User.find(params[:vid])
  #     save_previous_version(user)
  #   end
  # end

  def undo_destroy
    if params[:undo] =='Content'
      save_version
    end
    if params[:undo] =='Section'
      save_version
    end
    if params[:undo] =='Page'
      save_version
    end
    if params[:undo] =='Post'
      save_version
    end
    if params[:undo] =='Publication'
      save_version
    end
    if params[:undo] =='User'
      save_version
    end
    redirect_to admin_versions_path
  end

  private

  def save_version
    version =Version.find(params[:vid]).reify
    

    #possible delayed job?
    if params[:undo] == "Page"
      #update url table
      if version.next_version
        rewrite = Rewrite.new
        rewrite.request_path = version.next_version.url_path
        rewrite.request_path = version.next_version.url_path
        rewrite.target_path = version.url_path
        rewrite.page_id = version.id
        rewrite.save
      end
    end

    if params[:undo] == "Post"
      #update url table
      if version.next_version
        rewrite = Rewrite.new
        rewrite.request_path = version.next_version.slug
        rewrite.target_path = version.slug
        rewrite.post_id = version.id
        rewrite.save
      end
    end

    version.save

    if params[:undo] =='Content'
      restore_section(version)
    end

    v = Version.find(params[:vid])
    v.destroy
  end

  def save_previous_version(version)
    version = version.previous_version
    version.save
  end

  def restore_section(v)
    version =Version.where(:item_id => v.section_id).last.reify
    version.save
    v = Version.where(:item_id => version).last
    v.destroy
  end

end
