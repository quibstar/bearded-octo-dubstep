class Admin::PagesController < ApplicationController
	
	before_filter :authenticate_user! 
	before_filter :page_params, :only => [:create]
	layout 'admin/admin'

		def index
			@pages = Page.order(:content_status)
		end

	  def show
	    if params[:url_path].nil?
	      @page = Page.find_by_url_path(params[:url_path] == 'home')
	      @title = @page.title.capitalize
	      @sections = Section.where(:page_id => @page.id).order('sections.position ASC')
	      @footer = Section.where(:footer_id => @page.footer_id).order('sections.position ASC')
	      
	    else
	      page = params[:url_path].split('/').last
	      @page = Page.find_by_url_path(page)  
	      @title = @page.title.capitalize
	      @sections = Section.where(:page_id => @page.id).order('sections.position ASC')
	      @footer = Section.where(:footer_id => @page.footer_id).order('sections.position ASC')
	    end
	  end
	
	def new 
		@page = Page.new
		@title = "New Page Group"
		get_templates
		render :layout => false
		# respond_to do |format|
		#   format.html
		#   format.js
		# end
	end
	
	def create 
		get_templates
	    if params[:page][:parent_id] == '0'
			params[:page][:url_path] = params[:page][:title].parameterize
	    else
	    	page = Page.find(params[:page][:parent_id])
	    	params[:page][:url_path] = page.url_path + "/" + params[:page][:title].parameterize
	    end
    
		@page = Page.new(page_params)
		if @page.save 
			flash[:success]= "Successfully created page."
		end
		respond_to do |format|
			if @page.save
				if params[:redirect]
					format.html {redirect_to admin_page_sections_path(@page)}
				else
					format.html {redirect_to admin_navigations_path}
				end
				format.js
			else
				@title = "New page"
				format.html { render :action => :new }
				format.js
			end
		end 

	end
	
	def edit
		@page = Page.find(params[:id])
		@title = @page.title.capitalize
		get_templates
		render :layout => false
	end
	
	def update 
		get_templates
		@page = Page.find(params[:id])

		if !params[:page][:content_status]
			# update parent id if page move to a new nav group
			if @page.navigation_id != params[:page][:navigation_id].to_i
				params[:page][:parent_id] = '0'
			end


			#url slug
			if params[:page][:parent_id] == '0'
				params[:page][:url_path] = params[:page][:title].parameterize
		  else
		   	page = Page.find(params[:page][:parent_id])
		    params[:page][:url_path] = page.url_path + "/" + params[:page][:title].parameterize
		  end
		end



		#add to rewrite table
		if @page.url_path != params[:page][:url_path]
			rewrite = Rewrite.new
			rewrite.request_path = @page.url_path
			rewrite.target_path = params[:page][:url_path]
			rewrite.page_id = @page.id
			rewrite.save
		end
		
		#set url to nothing for home page link
		# if @page.id == 1
		# 	params[:page][:url_path] = ''
		# end

		if  @page.update_attributes(page_params)
			flash[:success]= "Successfully updated page."

			# rename sub pages
			child_page = Page.where(:parent_id => @page.id)
			child_page.each do |child|
				rename_sub_pages(@page, child)
			end
			

		end
		respond_to do |format|
			if @page.save
				if params[:redirect]
					format.html {redirect_to admin_page_sections_path(@page)}
				else
					format.html {redirect_to admin_navigations_path}
				end
				format.js
			else
				@title = "Edit page"
				format.html { render :action => :edit }
				format.js
			end
		end
	end
	
	def destroy
		page = Page.find(params[:id])
		sections = Section.where(:page_id => page.id)
		sections.each do |s|
			s.destroy
		end

		pages = Page.where(:parent_id => page.id)

		if pages.count > 0 
			flash[:success]= "There were sub pages of the page you just deleted. We moved them to the top level and marked them as un-published."
		end
		pages.each do |p|
			p.update_attributes(:parent_id => 0, :published => false, :url_path => p.url_path.split("/").last)
		end

		nav = NavigationBranch.where(:navigation_page => page)
		nav.each do |n|
			n.destroy
		end
		
		page.destroy
		redirect_to admin_navigations_path
	end


  def sort
		page_id  			= params[:page_id].to_i
    parent_id 			= params[:parent_id].to_i
    previous_position   = params[:previous_position].to_i
    next_position   	= params[:next_position].to_i
    child_of  			= params[:child_of].to_i
    navigation_group   	= params[:navigation_group].to_i
    parent_group   		= params[:parent_group].to_i

	#if page id == 1 bypass everything this is the home page
    if page_id != 1
		page = Page.find(page_id)
		if previous_position == 0
			new_position = 0
		else
			new_position = previous_position + 1
		end

		if child_of != 0
			parent_page = Page.find(child_of)

			# rename sub pages
			rename_sub_pages(parent_page, page)

		else
			new_path = page.url_path.split('/').last
			page.update_attributes(:url_path => new_path )

			# rename sub pages
			rename_sub_pages(0,page)
		end


		page.update_attributes(:parent_id => child_of, :position => new_position)

		page_order = Page.where('navigation_id =? and parent_id = ? and id >= ?', navigation_group, parent_group, next_position)
		page_order.each do |po|
			po.position = po.position + 1
			po.save!
		 end
	end

	home = Page.find(1)
	home.update_attributes(:position => 0, :parent_id => 0)
    render :nothing => true
    
  end
  
	def rename_sub_pages(parent, child)
		if parent != 0
			#find parent page
			last_url_segment = child.url_path.split('/').last
			new_path  = "#{parent.url_path}/#{last_url_segment}"
			child.update_attributes(:url_path => new_path )
		end
			new_child = Page.find_by_parent_id(child.id)
			if new_child
				rename_sub_pages(child, new_child)
			end
	end 

	def page_params
		params.require(:page).permit(:parent_id, :position, :title, :navigation_text, :navigation_id, :published, 
					:show_in_nav, :keywords, :description, :template_id, :footer_id, :slider_id, 
					:multi_navigation_id, :mobile, :url_path, :redirect,:content_status)
	end
  	
end

