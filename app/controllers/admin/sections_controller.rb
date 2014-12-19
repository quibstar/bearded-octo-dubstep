class Admin::SectionsController < ApplicationController
  
  before_filter :authenticate_user! 
  before_filter :section_params, :only => :create
  layout 'admin/admin'

  def index
    get_templates
  	if params[:page_id]
	  	@page =Page.find(params[:page_id])
      # sections is used for sections, sub_section, tabs and accordions
      @sections = @page.sections
  	end
  	
  	if params[:footer_id]
		  @footer = Footer.find(params[:footer_id])
		  @footer_sections = @footer.sections
  	end
 
  	if params[:publication_id]
		  @publication =Publication.friendly.find(params[:publication_id])
		  @sections = @publication.sections
  	end
  	
    if params[:multi_navigation_id]
      @multi_navigation = MultiNavigation.find(params[:multi_navigation_id])
      @sections = @multi_navigation.sections
    end

    if params[:shared_content_id]
      @shared_content = SharedContent.find(params[:shared_content_id])
      @sections = @shared_content.sections
    end

  	@section = Section.new
    @section.build_content
  	# 1.times { @section.contents.build}
  	
  end

  def new
  	if params[:page_id]
	  	@page =Page.find(params[:page_id])
	  	@sections = @page.sections
	  	@images = Image.page(params[:page]).per(2)
  	end
  	
  	if params[:footer_id]
			@footer =Footer.find(params[:footer_id])
			@footers = @footer.sections
  	end
 
  	if params[:publication_id]
			@publication =Publication.friendly.find(params[:publication_id])
			@publications = @publication.sections
  	end
  	
    if params[:multi_navigation_id]
      @multi_navigation = MultiNavigation.find(params[:multi_navigation_id])
      @multi_navigations = @multi_navigation.sections
    end

    if params[:shared_content_id]
      @shared_content = SharedContent.find(params[:shared_content_id])
      @shared_contents = @shared_content.sections
    end

  	@section = Section.new
    @section.build_content
  	# 1.times { @section.contents.build}
  	#1.times {@section.slideshows.build}

    @asset_by_category = @section.build_asset_by_category
    @socialNetworks = @section.build_social_network
    @navigationGroup = @section.build_navigation_group
    @navigationBranch = @section.build_navigation_branch

  	render :layout => false
  end
  
  
   def edit
    @section = Section.find(params[:id])
  	if params[:page_id]
	  	@page = Page.find(params[:page_id])
  	end
  	
  	if params[:footer_id]
		  @footer =Footer.find(params[:footer_id])
  	end
 
  	if params[:publication_id]
		  @publication = Publication.friendly.find(params[:publication_id])
  	end

    if params[:multi_navigation_id]
      @multi_navigation = MultiNavigation.find(params[:multi_navigation_id])
    end

    # if params[:shared_content_id]
    #   @shared_content = SharedContent.find(params[:shared_content_id])
    # end
  	render :layout => false
  end
  

  def create
  	params[:section][:column_class] = params[:section][:column]
    @section = Section.new(section_params)
    if @section.save 
     	flash[:success]= "Successfully created section."
    end
    respond_to do |format|
      if @section.save
          format.html {go_to_resource}
          format.js
      else
        @title = "New Section"
        format.html { render :action => :new }
        format.js
      end
    end 
  end


  def update
   # if params[:section][:slideshows_attributes]
   #    params[:section][:slideshows_attributes]['0'][:image_ids] ||= []
   #    params[:section][:slideshows_attributes]['0'][:testimonial_ids] ||= []
   #    params[:section][:slideshows_attributes]['0'][:youtube_ids] ||= []
   #  end
      
    # #in case someone unslects all the shared contents
    # comment out cause of transfer might have to correct this
    # params[:section][:shared_content_ids]||= []


  	if params[:section][:column]
  		params[:section][:column_class] = params[:section][:column]
  	end
  	
	  @section = Section.find(params[:id])
		if @section.update_attributes(section_params)
			flash[:success]= "Successfully updated section."
		end
    respond_to do |format|
      if @section.save
        format.html {go_to_resource}
        format.js
      else
        @title = "Edit Section"
        format.html { render :action => :edit }
        format.js
      end
    end
	end

  def destroy
    section = Section.find(params[:id])
    
    #recursive function to remove child section for tabs and accordions
    delete_sub_sections(params[:id])
    
    section.destroy

    go_to_resource_after_delete(section)
  end
  
  def delete_sub_sections(id)
    sections = Section.where(:parent_id => id)
    if sections
      sections.each do |s|
        delete_sub_sections(s)
        s.destroy

        #remove content sections
        contents = Content.where(:section_id => s)
        if contents
          contents.each do |c|
            c.destory
          end
        end
      end
    end
  end

  
  
  def sort
    target_id   = params[:target_id].to_i
    position_id = params[:position_id].to_i
    parent_id  	= params[:parent_id].to_i
    current_id  = params[:current_id].to_i
    page_id  = params[:page_id].to_i
    loc_id  = params[:loc_id].to_i
    
    section = Section.find(current_id)
    section.update_attributes(:position => position_id, 
                              :parent_id => target_id,
                              :location => loc_id)
                              
    section_order = Section.where('page_id = ? and position >= ?', page_id, position_id)
    section_order.each do |so|
    so.position = so.position + 1
    so.save!
    end
  end
  
  # copy/move view
  def section_cpmv
    @section = Section.find(params[:id])
    @page = Page.find(@section.page_id)
    @navigations = Navigation.order(:id)
    render :layout => false
  end

  def image_search
    if params[:title].present?
      @search_images = Image.where(['title LIKE ?', "#{params[:title]}%"])
    end
  end
  
  private

  
  def go_to_resource
      # if updateing footer     
    if params[:route] == 'footer'
			redirect_to admin_footer_sections_path(@section.footer_id)
           
    elsif params[:route] == 'page'
    	redirect_to admin_page_sections_path(@section.page_id)
    	
     elsif params[:route] == 'publication'
      redirect_to admin_publication_sections_path(@section.publication_id)

    elsif params[:route] == 'multi navigation'
      redirect_to admin_multi_navigation_sections_path(@section.multi_navigation_id)

      elsif params[:route] == 'shared content'
      redirect_to admin_shared_content_sections_path(@section.shared_content_id)
    end
  end
  
    def go_to_resource_after_delete(section)
      # if updateing footer     
    	if params[:footer_id]
        flash[:success]= "Successfully removed content."
        redirect_to admin_footer_sections_path(section.footer_id)
           
    	elsif params[:page_id]
        flash[:success]= "Successfully removed content."
        redirect_to admin_page_sections_path(section.page_id)
      
     	elsif params[:publication_id]
        flash[:success]= "Successfully removed content."
        redirect_to admin_publication_sections_path(section.publication_id)

      elsif params[:multi_navigation_id]
        flash[:success]= "Successfully removed content."
        redirect_to admin_multi_navigation_sections_path(section.multi_navigation_id)

       elsif params[:shared_content_id]
        flash[:success]= "Successfully removed content."
        redirect_to admin_shared_content_sections_path(section.shared_content_id)
      end
  end 


  def section_params
    params.require(:section).permit!
  end
end 

