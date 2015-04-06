class ApplicationController < ActionController::Base
  protect_from_forgery
  

  def check_rewrite_table(url)
    request = Rewrite.find_by_request_path(url)
    if request
      if request.page_id
        page = Page.find_by_id(request.page_id)
        if page && page.published == true
            redirect_to "/#{page.url_path}"
        else
          not_found_404
        end
      elsif request.post_id
        post = Post.find_by_id(request.post_id)
        if post && post.published == true
            publication = post.publication  
            redirect_to post_show_path(publication,post)
        else
          not_found_404
        end
      end
    else
      not_found_404
    end
  end

  # routing errors
  # 404
  def not_found_404
    # render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    @page = Page.find_by_url_path('404')   
    @title = @page.title.capitalize
    @sections = @page.sections.where(:visible => 1).includes(:content)
    @footer = Section.where(:footer_id => @page.footer_id, :visible => 1).order('sections.position ASC')
    @templates = Template.all
    @sideNav = Page.where(:navigation_id => 1, :show_in_nav => true).order(:position)
    @setting = Setting.first
  end
	
  #chooses layout
  def layout_chooser
    if user_signed_in?
      'admin/admin'
    else
      'application'
    end
  end
  
  # get templates
  def get_templates
		@templates = Template.all
	end
	
	
	def pluralize_without_count(count, noun, text = nil)
		if count != 0
	 	 count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
		end
	end

  def after_invite_path_for(resource)
    admin_users_path
  end
	
  def after_sign_in_path_for(resource)
    admin_topics_path 
  end
  
  def after_sign_up_path_for(resource)
  	admin_topics_path
  end

  #cancan authorization
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to admin_dashboard_index_path
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
  
end
