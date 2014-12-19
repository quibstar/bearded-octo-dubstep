class SiteController < ApplicationController

	before_filter :set_errors 
	
	def show
		if params[:url_path].nil?
		  @page = Page.find(1)
		  @title = @page.title.capitalize
		  @sections = @page.sections.where(:visible => 1).includes(:content)
		  @footer = Section.where(:footer_id => @page.footer_id,:visible => 1).order('sections.position ASC')
		else
		  page = params[:url_path]
		  @page = Page.find_by_url_path(page) 
		  if @page 

		  	if @page.redirect 
		  		@redir_page = Page.find(@page.redirect)
		  		if @redir_page.published == true
		  			redirect_to "/#{@redir_page.url_path}"
		  		else
		  			check_rewrite_table(@redir_page)	
		  		end
		  	end

		  	if @page.published == true 
		      @title = @page.title.capitalize
		      @sections = @page.sections.where(:visible => 1).includes(:content)
		      @footer = Section.where(:footer_id => @page.footer_id, :visible => 1).order('sections.position ASC')
		     end

		    # changed 12-12-13
				@templates = Template.all
				@sideNav = Page.where(:navigation_id => @page.navigation_id, :show_in_nav => true).order(:position)
				@setting = Setting.first

		  elsif Post.find_by_slug(request.fullpath.split('/').last)
		  	post = Post.find_by_slug(request.fullpath.split('/').last) 
		  	publication = post.publication	
				redirect_to post_show_path(publication,post)
		   else
		     #function in application controller for 404 page or pages that are not published
		     check_rewrite_table(page)
		   end
		end
	end
	
	
	def submit_form
	# create arrays
	errors = []
	required = []
	
	session[:errors] = ''
	
	#get required
	if params[:required].present?
		params[:required].each do |key, value|
		  params[:field].each do |k, v|
		    if value == 'true' && key == k && v.empty?
		    	errors << k
		    end
		    # for multi select elements : radio, checkbox
		    if !params[:field].has_key?(key)
		    	errors << key
		    	session.delete key.to_sym
		    end
		    errors.uniq!
		  end
		end
	end
	
	if errors.empty?
	  @fields = []
	  params[:field].each do |f|
	    @fields << f
	  end
	  @form = Form.find(params[:form_id])
	  FormMailer.form_submit(@form,@fields).deliver

	  #below is delayed_job
	  #FormMailer.delay.form_submit(@form,@fields)
	  #reset session after update
	  
	  params[:field].each do |k, v|
	    session[k] = nil
	  end
	  
	  session[:errors] = ''
	  Rails.logger.debug 
	  form_confirmation = Form.find(params[:form_id])
	  flash[:notice] = form_confirmation.confirmation
	else
	  #reset session after update
	  #reset_session
	  params[:field].each do |k, v|
	  	if v.present?
	    	session[k] = v
	    else
	    	session.delete k.to_sym
			end
	 	end
	  session[:errors] = errors
	end

	page = params[:url_path].split('/').last
	redirect_to  :action => 'show', :url_path => page
	end
	
	
	#feeds
	def feed
		publication = Publication.find(1)
	    @posts = Post.publication.where(:select => "title, author, id, content, posted_at").order("posted_at ASD").limit(20) 
	
	    respond_to do |format|
	      format.rss { render :layout => false } #index.rss.builder
	    end
	end
	
	private
	
	def set_errors
	  @errors = session[:errors]
	  session[:errors] = nil?
	  session = nil
	end
	

end
