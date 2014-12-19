module ApplicationHelper


  # Gets class for the body tag
  def column_type( pageObject, controller)
    for t in Template.all do
      if t.id == pageObject.template_id
        @column_type = t.temp_class
        if controller == 'page'
          @body_class = pageObject.url_path.parameterize
        elsif controller == 'post'
          @body_class = pageObject.title.parameterize
        elsif controller == 'publication'
          @body_class = pageObject.title.parameterize
        end
      end
    end
  end
  
  def title
    settings = Setting.first 
    if !settings.nil?
      base_title = settings.site_title
    else
      base_title = " "
    end
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end 
  
  JOINER = " &raquo; "
  def bread_crumb
    if @category || @post
      return ''
    end
    if  @page && @page.id == 1 || params[:search]
      return ''
    end

    if controller.controller_name != 'passwords' || controller.controller_name != 'sessions'
      return ''
    end

      home = link_to 'home', root_url 
      path = ''
      links = request.fullpath.split('/')
      last_link = links.last
      links.pop
      # links.shift # this remove the first element
      links.each_with_index do |link, i|
        if link.present?
          path += "<a href=" + sub_links(links, i) + links[i] + ">" + link + "</a>" + JOINER
        else
          path += JOINER
        end
      end
        path <<  last_link
        home << path.html_safe
        # path.html_safe
  end

  def sub_links(links, i)
    href = ''
    l = 0
    while l < i
      href << links[l] + '/'
      l += 1
    end 
    href
  end

  # special singular and pluralizer
  def pluralize_without_count(count, noun, text = nil)
    if count != 0
      count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
    end
  end
  
  
  #get avatar for logged in users
  def avatar_url(email)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=30"
  end

    def avatar_url_large(email)
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=50"
  end


  def sub_pages(navigation, url)
    nav = ''
    navigation.each do |n|
        if n.url_path == url
            id = n.id
        end
        unless id.nil?
          nav += id.to_s
        end
    end
    sub_nav(navigation, nav.to_i,url,1,1)
  end
  
  def get_parent_page(sideNav, current_page_id, navigation_id)
    content = ''
    parent_id = nil

    sideNav.each do |p|
      if p.id == current_page_id
        parent_id = p.parent_id
      end
    end

    if parent_id == 0
      # 1 and 1 are for navigation group 1 = primary and 1 is for iteration
      content << sub_nav(sideNav,current_page_id,navigation_id,1)
    else
      sideNav.each do |p|
        if p.id == parent_id && p.parent_id == 0
          # show the side nav
          content << sub_nav(sideNav,p.id,navigation_id,1)
        elsif p.id == parent_id && p.parent_id != 0
          content << get_parent_page(sideNav, p.parent_id,p.navigation_id)
        end
      end
    end
    content.html_safe
  end


  def sub_nav(navigation, id,navigation_group,i, numberOfColumns = 1, showChildren = 1)

    #set some variables for "first" and "last" links and sub_nav count    
    i = 1
    j = 1
    page_count = 0
    navigation.each do |p|
      if p.parent_id == id
        page_count = page_count + 1
      end
    end
    
    nav = ""
    navigation.each do |p|

      # for columns

      pageCount = page_count.to_f / numberOfColumns.to_f

      # don't divide by zero
      if pageCount > 1
        remain = j % pageCount.ceil
      end

      if p.parent_id == id
        
        
        
        # Put first and last on list items
          class_name = "class ='order-#{p.position} first page-#{p.id}'" if j == 1
          class_name = "class ='order-#{p.position} last page-#{p.id}'" if j == page_count
          class_name = "class='order-#{p.position} page-#{p.id} '" if page_count  == 1
          
          # place in ordered list
          ordered_list_start = "<span class='show-sub'></span><ol class='first-list'>" if j == 1
          
          # close ordered list
          if j == page_count 
            ordered_list_end = "</ol> <!--last-list-->"

          # list columns
          elsif remain == 0
               ordered_list_end = "</ol><ol>"           
          end         
          
          # increment, must be after 'ordered_list_start' and 'ordered_list_start' or lists will break
          j += 1
          
        # create list items   
        content = "#{ordered_list_start} <li #{class_name} >"
        content << "<span></span><a " + current_class(params[:url_path],p.url_path ) + " href=""/" + p.url_path + ">"
        if p.navigation_text.present?
          content << p.navigation_text
        else
          content << p.title 
        end
        content << "</a>"
        # if there are sub pages create them - this is for mutli-dropdown
          if showChildren == 1
              unless sub_nav(navigation, p.id,p.url_path,navigation_group,i).nil?
                content += sub_nav(navigation,p.id,p.url_path,navigation_group,i)
              end
            end
        content <<"</li>#{ordered_list_end}"
        nav << content  
      end       
    end
    nav.html_safe
  end

  
  
  def current_class(param_path , url_path)
  # vars
  # params[:url_path]
  # sub.url_path
  if param_path.nil?
      current = ''
  elsif(param_path == url_path)
    current = 'class="current"'
  else
    current = ""
  end
  
  end
  
  
  def public_current_class(param_path , url_path)
    # vars
    # params[:url_path]
    # sub.url_path
    if param_path.nil?
        current = ''
    elsif(param_path == url_path)
      current = 'current'
    else
      current = ""
    end
  end
  
  # creates side nav list item
  def nav_groups
    navigations = Navigation.order(:id)
      navigation = ''
      count = navigations.count
      navigations.each_with_index do |n, i|
        if i == (count -1) 
          liClass = 'last'
        else
          liClass = ''
        end
        content = "<li class='" + liClass  +" root'><a href='/admin/navigations/" + n.id.to_s + "'>" + n.nav_group.capitalize + "</a>"
          if sidebar_sub_nav(n.pages)
            content += sidebar_sub_nav(n.pages) 
          end
        content << "</li>"
        navigation << content
      end
    
    navigation.html_safe
  end

  # 
  # Helper for nav_groups function (right abover this one)
  # 
  def sidebar_sub_nav(pages, parent=0, cls="subnav")
    newCls = "sub-" + cls
    count = pages.where(:parent_id => parent).count
    content = ""
    content << "<span></span>" if count > 0
    content += "<ul class=" + newCls + ">" if count > 0
    pages.where(:parent_id => parent).order('position').each do |p|
      content += "<li>"
      content += link_to p.title, admin_page_sections_path(p.id) 
      if sidebar_sub_nav(pages,p.id,newCls )
        content += sidebar_sub_nav(pages,p.id,newCls )
      end
      content << "</li>"
    end
    content << "</ul>" if count > 0
  end
  
  
  # used in admin_sidebar.html.haml
  def admin_side_nav(resource, sections)
    #resource is the table
    #if secton false the it goes straight to the edit method in the controller
    table = resource.classify.constantize
    results = table.all
 
    navigation = ''
    count = results.count
    results.each_with_index do |n, i|
      if i == (count -1) 
        liClass = 'last'
      else
        liClass = ''
      end
      if resource == 'users'
        if n.name.length > 0
          title = n.name

        else
          title = n.email + '<small style="font-size:9px; color:red;"> Missing Name</small>'
        end
        
      else
        title = n.title.capitalize
      end
      content = "<li class=" + liClass + "><a href='/admin/"+ resource + "/" + n.id.to_s + "/" + sections +"'>" + title + "</a></li>"
    navigation << content
    end
    navigation.html_safe
  end
  
  
  #
  #
  # status for being visible
  def status_tag(boolean, options={})
    options[:true]          ||= ''
    options[:true_class]    ||= 'status true'
    options[:false]         ||= ''
    options[:false_class]   ||= 'status false'
    
    if boolean
      content_tag(:span, options[:true], :class => options[:true_class])
    else
      content_tag(:span, options[:false], :class => options[:false_class])
    end
  end
  
  def status_text(boolean)
    if boolean
      content_tag(:span, "Hidden", :class => 'status-text hidden')
      
    else
      content_tag(:span, "Visible", :class => 'status-text visible')
    end
  end

  #
  #
  # sanitize links
  def sanitize_links(link)
    if link[0..6] == 'http://' || link[0..7] == 'https://'
      link
    else
      'http://' + link
    end
  end
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms
  def set_resource
    if @page
      resource = @page
    end

    if @footer
      resource = @footer
    end

    if @publication
      resource = @publication
    end

    if @multi_navigation
      resource = @multi_navigation
    end

    if @shared_content
      resource = @shared_content
    end
    
    resource
  end
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms 
  def set_resource_id
    if @page
      resource = @page.id
    end

    if @footer
      resource = @footer.id
    end

    if @publication
      resource = @publication.id
    end

    if @multi_navigation
      resource = @multi_navigation.id
    end

    if @shared_content
      resource = @shared_content.id
    end

    resource
  end
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms
  def set_resource_symbol
    if @page
      resource = :page_id
    end

    if @footer
      resource =:footer_id
    end

    if @publication
      resource =:publication_id
    end

    if @multi_navigation
      resource =:multi_navigation_id
    end

    if @shared_content
      resource =:shared_content_id
    end

    resource
  end
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms
  def set_resource_route
    if @page
      resource = 'page'
    end

    if @footer
      resource = 'footer'
    end

    if @publication
      resource = 'publication'
    end

    if @multi_navigation
      resource = 'multi navigation'
    end

    if @shared_content
      resource = 'shared content'
    end

    resource
  end
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms
  def set_resource_path(s)
    if @page
       resource = admin_page_section_path(@page, s)
    end
    
    if @footer
      resource = admin_footer_section_path(@footer, s)
    end
    
    if @publication
      resource = admin_publication_section_path(@publication, s)
    end

    if @multi_navigation
      resource = admin_multi_navigation_section_path(@multi_navigation, s)
    end

    if @shared_content
      resource = admin_shared_content_section_path(@shared_content, s)
    end
    
    resource
  end 
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms
  def edit_resource_path
    if @page
       resource = edit_admin_page_path(set_resource)
    end
    
    if @footer
      resource = edit_admin_footer_path(set_resource)
    end
    
    if @publication
      resource = edit_admin_publication_path(set_resource)
    end

    if @publication
      resource = edit_admin_publication_path(set_resource)
    end

    if @multi_navigation
      resource = edit_admin_multi_navigation_path(set_resource)
    end

    if @shared_content
      resource = edit_admin_shared_content_path(set_resource)
    end
    
    resource
  end 
  
  #
  # Get resource based controller i.e. pages, footer or publications
  # for forms
  def goto_resource_path
    if @page
       resource = admin_navigations_path
    end
    
    if @footer
      resource = admin_footers_path
    end
    
    if @publication
      resource = admin_publications_path
    end

    if @multi_navigation
      resource = admin_multi_navigations_path
    end

    if @shared_content
      resource = admin_shared_contents_path
    end
    
    resource
  end 
  
  def modal_link( section_type, location, sid)
  if @page
    resource = new_admin_page_section_path(@page, :section_type => section_type, :location => location, :sid => sid)
  end
  
  if @footer
    resource = new_admin_footer_section_path(@footer,:section_type => section_type, :location => location, :sid => sid)
  end
  
  if @publication
    resource = new_admin_publication_section_path(@publication,:section_type => section_type, :location => location, :sid => sid)
  end

  if @multi_navigation
    resource = new_admin_multi_navigation_section_path(@multi_navigation,:section_type => section_type, :location => location, :sid => sid)
  end

  if @shared_content
    resource = new_admin_shared_content_section_path(@shared_content,:section_type => section_type, :location => location, :sid => sid)
  end
  
  resource
  end
  
  
   def edit_modal_link( section_type, location, sid)
  if @page
    resource = edit_admin_page_section_path(@page, sid, :section_type => section_type, :location => location, :sid => sid)
  end
  
  if @footer
    resource = edit_admin_footer_section_path(@footer,sid,:section_type => section_type, :location => location, :sid => sid)
  end
  
  if @publication
    resource = edit_admin_publication_section_path(@publication,sid, :section_type => section_type, :location => location, :sid => sid)
  end

  if @multi_navigation
    resource = edit_admin_multi_navigation_section_path(@multi_navigation,sid, :section_type => section_type, :location => location, :sid => sid)
  end

  if @shared_content
    resource = edit_admin_shared_content_section_path(@shared_content,sid, :section_type => section_type, :location => location, :sid => sid)
  end
  
  resource
  end
  
  def set_parent_id(params) 
    # set parent id
  if params.empty?
    parent_id = 0
  else
    parent_id = params
  end
  parent_id
  end
  
#settings for header logo, h1, tagline and contact (footer and contact page)
  def settings(obj)
    setting = Setting.first
    if obj == 'site'
      if setting
          setting = setting.site_title
        else
          setting = "Blank Title"
        end
    end
    
    if obj == 'tag_line'
      if setting
          setting = setting.tag_line
        else
          setting = "Blank Tag Line"
        end
    end
    
    if obj == 'logo'
      if setting
          setting = image_tag setting.logo_url()
        else
          setting = "rails.png"
        end
    end

    if obj == 'thumb-logo'
      if setting
          setting = image_tag setting.logo_url(:thumb)
        else
          setting = "rails.png"
        end
    end
    
    if obj == 'analytics'
      if setting
          setting = setting.analytics
        else
          setting = ""
        end
    end
    
    if obj == 'url'
      setting =  "<a href='" + setting.address + "' >" + setting.site_title + "</a>" 
    end
    
    if obj == 'contact'
      setting ='<p>'
      setting << "<span class='address'" + setting.address + "</span>"
      setting << "<span class='city'" + setting.city + "</span>"
      setting << "<span class='state'" + setting.state + "</span>"
      setting << "<span class='zip'" + setting.zip + "</span>"
      setting << "</p>"
      settings.html_safe
    end
    
    if obj == 'phone'
      setting =''
      setting << "<span class='phone'" + setting.phone + "</span>"
      settings.html_safe
    end
    
    if obj == 'fax'
      setting =''
      setting << "<span class='fax'" + setting.fax + "</span>"
      settings.html_safe
    end
    
    if obj == 'email'
      setting =''
      setting << "<span class='email'" + setting.email + "</span>"
      settings.html_safe
    end
    
    return setting
  end
  
  
 def smart_truncate(s, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
    end
    a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '...' : '')
  end
  
  
  def meta_keywords
    if @page
      keywords = @page.keywords
      
    elsif @publication
      keywords = @publication.title
      if @post
        post_keywords = @post.title
        keywords + ": " + post_keywords 
      end

    else
      keywords = ''
    end
    return keywords
  end
  
  def meta_description
    if @page
      description = @page.description
      
    elsif @publication
      description = @publication.title
      if  @post
        post_dectription = @post.title
        description + ', ' + post_dectription
      end 
    else
      description = ''
    end
    return description
  end
  
  #builds navigation for navigation branch 
  def branch_sub_nav(navigation, id,i, nb)
    #set some variables for "first" and "last" links and sub_nav count    
    i = 1
    j = 1
    page_count = 0
    navigation.each do |p|
      if p.parent_id == id
        page_count = page_count + 1
      end
    end
    nav = ""

    navigation.each do |p|
      if p.parent_id == id
        # place in ordered list
          ordered_list_start = "<ol>" if j == 1

          # close ordered list
          if j == page_count
            ordered_list_end = "</ol>"
          end       
          
          # increment, must be after 'ordered_list_start' and 'ordered_list_start' or lists will break
          j += 1

        content = "#{ordered_list_start}<li>"
        content += link_to p.title, "#", :data => {:page => p.id}
        content += nb.radio_button :navigation_page , p.id
        unless branch_sub_nav(navigation,p.id,i, nb).nil?
          content << branch_sub_nav(navigation, p.id,i, nb)
        end
        content += "</li>#{ordered_list_end}"
        nav += content  
      end       
    end
    nav.html_safe
  end

  #builds navigation for navigation branch 
  def edit_branch_sub_nav(navigation, id,i,option_id, option_function_value)

    #set some variables for "first" and "last" links and sub_nav count    
    i = 1
    j = 1
    page_count = 0
    navigation.each do |p|
      if p.parent_id == id
        page_count = page_count + 1
      end
    end
    nav = ""
    navigation.each do |p|

      if p.id == option_function_value
        checked = "checked='checked'"
      else
        checked = ""
      end

      if p.parent_id == id

        # place in ordered list
          ordered_list_start = "<ol>" if j == 1
          
          # close ordered list
          if j == page_count
            ordered_list_end = "</ol>"
          end       
          
          # increment, must be after 'ordered_list_start' and 'ordered_list_start' or lists will break
          j += 1

        content = "#{ordered_list_start}<li>"
        content += link_to p.title, "#", :data => {:page => p.id}
        content += "<input " + checked + " id='section_options_attributes_1_function_value_" + p.id.to_s + "' name='section[options_attributes][0][function_value]' type='radio' value=" + p.id.to_s + ">"
        content += "<input id='section_options_attributes_0_id' name='section[options_attributes][0][id]' type='hidden' value='" + option_id.to_s + "'>"
        unless edit_branch_sub_nav(navigation,p.id,i,option_id, option_function_value).nil?
          content << edit_branch_sub_nav(navigation, p.id,i,option_id, option_function_value)
        end
        content += "</li>#{ordered_list_end}"
        nav += content  
      end       
    end
    nav.html_safe
  end


   #
  #
  # CSS for complex slider
  def make_css(slider)
    file = Rails.public_path + "/slider#{slider.id}.css"    
    if FileTest.exists?(file)
      test = "<link href='#{request.protocol + request.host_with_port}/slider#{slider.id}.css' media='screen' rel='stylesheet' type='text/css'>"
      test.html_safe
    else
    output = ''
    css = ''
    if slider.effectType == "3D"
      css += "#section-slider-#{slider.id} {width: #{slider.imageWidth + 100}px;height: #{slider.imageHeight + 100}px;}"
      css += "#section-slider-#{slider.id}  img {visibility: hidden; width:100%;}"
    end
    if slider.effectType == "2D"
      css += "#section-slider-#{slider.id} {width: #{slider.imageWidth}px;height: #{slider.imageHeight}px;}"
      css += "#section-slider-#{slider.id}  img {visibility: hidden; width:100%;}"
    end
    slider.slides.order('id ASC').each_with_index do |slide ,i|
      # css += "#slidehtml#{slider.id}-#{slide.id} h3 {width: #{slide.header_width}%;color: ##{slide.header_color};font-size: 28px;padding: 0;}"
      # css +=  "#slidehtml#{slider.id}-#{slide.id} p {width: #{slide.content_width}%;color: ##{slide.content_color};font-size: 16px;padding: 0;}"
      # css += "#slidehtml#{slider.id}-#{slide.id} a {display: inline-block;background: #ddd;}"
      # css += "#slidehtml#{slider.id}-#{slide.id} a span {padding: 10px;}"
      css += "#slidehtml#{slider.id}-#{slide.id} h3 {width: #{slide.header_width}px;color: ##{slide.header_color};}"
      css += "#slidehtml#{slider.id}-#{slide.id} p {width: #{slide.content_width}px;color: ##{slide.content_color};}"
      css += "#slidehtml#{slider.id}-#{slide.id} a {display: inline-block;background: #ddd;}"
      # css += "#slidehtml#{slider.id}-#{slide.id} a span {padding: 10px;}"
    end
    output += css
    # File.open(file, 'w') {|f| f.write(output) }
    File.open(File.join(Rails.public_path, "slider#{slider.id}.css"), 'w+') do|f| 
      f.write(output) 
    end
    #test = "<script src='../slider#{slider.id}.js'></script>"
    test = "<link href='#{request.protocol + request.host_with_port}/slider#{slider.id}.css' media='screen' rel='stylesheet' type='text/css'>"
    test.html_safe
  end
  end


  #
  #
  # JS for complex slider
  def make_js(slider)
    file = Rails.public_path + "/slider#{slider.id}.js"   
    if FileTest.exists?(file)
      test = "<script src='#{request.protocol + request.host_with_port}/slider#{slider.id}.js'></script>"
      test.html_safe
    else
      
    script = ''
    js = "$(window).load(function(){"
    js += "$('#section-slider-#{slider.id}').ccslider({"

    attrs2D = []
    if slider.startSlide.present? 
      attrs2D << "startSlide: #{slider.startSlide}" 
    end 
    if slider.animSpeed.present? 
      attrs2D << "animSpeed: #{slider.animSpeed}" 
     end 
      attrs2D << "directionNav: #{slider.directionNav}"
      attrs2D << "controlLinks: #{slider.controlLinks}"

    if slider.controlLinkThumbs.present?  
      attrs2D << "controlLinkThumbs: #{slider.controlLinkThumbs}" 
      attrs2D << "controlThumbLocation: ''"
    end 

      attrs2D << "autoPlay: #{slider.autoPlay}"
    if slider.pauseTime.present?  
      attrs2D << "pauseTime: #{slider.pauseTime}"
    end 

      attrs2D << "pauseOnHover: #{slider.pauseOnHover}"
      attrs2D << "captions: #{slider.captions}"
    if slider.captionPosition.present? 
      attrs2D << "captionPosition: '#{slider.captionPosition}'"
    end 

    if slider.captionAnimation.present? 
      attrs2D << "captionAnimation: '#{slider.captionAnimation}'"
    end 

    if slider.captionAnimationSpeed.present? 
      attrs2D << "captionAnimationSpeed: #{slider.captionAnimationSpeed}"
    end 

    if slider.effectType == "2D" 
      attrs2D << "effectType: '2d'"
      attrs2D << "effect: '#{slider.effect_2d}'"
     if slider.animSpeed.present? 
      attrs2D << "animSpeed: #{slider.animSpeed}"
     end 
    end

    js += attrs2D.join(',')

    attrs3D = []

    if slider.effectType == "3D" 
      attrs3D << ",effectType: '3d'"
      attrs3D << "effect: '#{slider.effect_3d}'"
      attrs3D << "_3dOptions: {imageWidth: #{slider.imageWidth}"
      attrs3D << "imageHeight: #{slider.imageHeight}"
     if slider.innerSideColor.present? 
      attrs3D << "innerSideColor: '#{slider.innerSideColor}'"
     end  
      attrs3D << "transparentImg: #{slider.transparentImg}"
      attrs3D << "makeShadow: #{slider.makeShadow}"
     if slider.shadowColor.present? 
      attrs3D << "shadowColor: '#{slider.shadowColor}'"
     end 
     if slider.slices.present? 
      attrs3D << "slices: #{slider.slices} "
     end 
     if slider.rows.present? 
      attrs3D << "rows: #{slider.rows}"
     end 
     if slider.columns.present? 
      attrs3D << "columns: #{slider.columns}"
     end 
     if slider.delay.present? 
      attrs3D << "delay: #{slider.delay}"
     end 
     if slider.delayDir.present? 
      attrs3D << "delayDir: '#{slider.delayDir}'"
     end 
     if slider.depthOffset.present? 
      attrs3D << "depthOffset: #{slider.depthOffset}"
     end 
     if slider.sliceGap.present? 
      attrs3D << "sliceGap: #{slider.sliceGap}"
     end 
     if slider.easing.present? 
      attrs3D << "easing: '#{slider.easing}'"
     end 
     if slider.fallBack.present? 
      attrs3D << "fallBack: '#{slider.fallBack}'"
     end 
     if slider.fallBackSpeed.present? 
      attrs3D << "fallBackSpeed: #{slider.fallBackSpeed}"
    else
      attrs3D << "fallBackSpeed: 600"
    end 
     
    js += attrs3D.join(',')

    js += "}"
    end
    js += ",beforeSlideChange: function(index) {$(this).find('div.cc-html').children().hide();}"
    js += ",afterSlideChange: function(index) {"
    slider.slides.order('id ASC').each_with_index do |slide, i| 
      js += "if( index === #{i} ) {var children = $('#slidehtml#{slider.id}-#{slide.id}').children();children.css({ position: 'absolute', top: '0px', left: '0px'});"
      #js += render  :partial => "site/slideshow/transitions", :locals => { :slide => slide }
      js += transitions(slide)
      js += "}"
    end 
    js += "}"

    js += "});"
    firstSlide = slider.slides.order('id ASC').first 
    js += "var children = $('#slidehtml#{slider.id}-#{firstSlide.id}').children().hide();"
    js += "children.css({ position: 'absolute', top: '0px', left: '0px'});"
    #js += render  :partial => "site/slideshow/transitions", :locals => { :slide => firstSlide }
    js += transitions(firstSlide)
    js += "});"


    script += js
    File.open(File.join(Rails.public_path, "slider#{slider.id}.js"), 'w+') do|f| 
      f.write(script) 
    end
    test = "<script src='#{request.protocol + request.host_with_port}/slider#{slider.id}.js'></script>"
    test.html_safe
  end
  end

  #
  #
  # HTML for complex slider
  def make_slider_html(slider)
    html = ''
    content =''
    content += "<div id='section-slider-#{slider.id}' class='slider#{slider.effectType }'> "
    slider.slides.order('id ASC').each do |slide| 
      content += "<img src='#{ slide.image.image_url()}' data-htmlelem='#slidehtml#{slider.id}-#{slide.id}' data-thumbname='#{slide.image.image_url(:thumb)}' alt='#{slide.image.caption}'/> "
    end 
    content += "</div> "
    if !slider.captions
      slider.slides.order('id ASC').each_with_index do |slide ,i| 
        content += "<div id='slidehtml#{slider.id}-#{slide.id}' class='cc-html'> "
            if slide.header_visible == 1
              content += "<h3>#{ slide.header}</h3> "
            end 
            if slide.content_visible == 1 
              content += "<p>#{ slide.content}</p> "
            end 
            if slide.link_1_visible == 1 
              content += "<a class='btn' href='#{slide.link_1_url}'><span>#{slide.link_1_title}</span></a> "
            end 
            if slide.link_2_visible == 1 
              content += "<a class='btn' href='#{slide.link_2_url}'><span>#{slide.link_2_title}</span></a> "
            end 
          content += "</div> "
        end 
      end 
    html += content
    html.html_safe
    
  end

  #
  #
  # Transitions for comples slider
  def transitions(slide)
    html = ''
    trans = ''
      #h3
      if slide.header_slide_direction == 'top' 
        trans += "children.filter('h3').css({'top': '-100', 'left': #{slide.header_left.to_i}});"
        trans += "children.filter('h3').animate({ #{slide.header_slide_direction}: #{slide.header_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.header_slide_direction == 'right' 
        trans += "children.filter('h3').css({'top':#{slide.header_top.to_i},'left':300});"
        trans += "children.filter('h3').animate({ left: #{slide.header_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.header_slide_direction == 'bottom' 
        trans += "children.filter('h3').css({'top':500, 'left': #{slide.content_left.to_i}});"
        trans += "children.filter('h3').animate({ top: #{slide.header_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.header_slide_direction == 'left' 
        trans += "children.filter('h3').css({'top':#{slide.header_top.to_i},'left':-300});"
        trans += "children.filter('h3').animate({ left: #{slide.header_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.header_slide_direction == 'none' 
        trans += "children.filter('h3').css({'top':#{slide.header_top.to_i},'left': #{slide.header_left.to_i}});"
        trans += "children.filter('h3').animate({ opacity: 'toggle'}, 600);"
      end

      # p 
      if slide.content_slide_direction == 'top' 
        trans += "children.filter('p').css({'top': '-100','left': #{slide.content_left.to_i}});"
        trans += "children.filter('p').eq(0).delay(100).animate({ #{slide.content_slide_direction}: #{slide.content_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.content_slide_direction == 'right' 
        trans += "children.filter('p').css({'top':#{slide.content_top.to_i},'left':300});"
        trans += "children.filter('p').eq(0).delay(100).animate({ left: #{slide.content_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.content_slide_direction == 'bottom' 
        trans += "children.filter('p').css({'top':500, 'left': #{slide.content_left.to_i}});"
        trans += "children.filter('p').eq(0).delay(100).animate({ top: #{slide.content_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.content_slide_direction == 'left' 
        trans += "children.filter('p').css({'top':#{slide.content_top.to_i},'left':-300});"
        trans += "children.filter('p').eq(0).delay(100).animate({ left: #{slide.content_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.content_slide_direction == 'none' 
        trans += "children.filter('p').css({'top':#{slide.content_top.to_i},'left':#{slide.content_left.to_i}});"
        trans += "children.filter('p').eq(0).delay(100).animate({ opacity: 'toggle'}, 600);"
      end


      # links 
      if slide.link_1_slide_direction == "top" 
        trans += "children.filter('a').eq(0).css({'top': '-100','left': #{slide.link_1_left.to_i}});"
        trans += "children.filter('a').eq(0).delay(200).animate({ #{slide.link_1_slide_direction}: #{slide.link_1_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_1_slide_direction == 'right' 
        trans += "children.filter('a').eq(0).css({'top':#{slide.link_1_top.to_i},'left':300});"
        trans += "children.filter('a').eq(0).delay(200).animate({ left: #{slide.link_1_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_1_slide_direction == 'bottom' 
        trans += "children.filter('a').eq(0).css({'top':500, 'left':#{slide.link_1_left.to_i}});"
        trans += "children.filter('a').eq(0).delay(200).animate({ top: #{slide.link_1_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_1_slide_direction == 'left' 
        trans += "children.filter('a').eq(0).css({'top':#{slide.link_1_top.to_i},'left':-300});"
        trans += "children.filter('a').eq(0).delay(200).animate({ left: #{slide.link_1_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_1_slide_direction == 'none' 
        trans += "children.filter('a').eq(0).css({'top':#{slide.link_1_top.to_i},'left': #{slide.link_1_left.to_i}});"
        trans += "children.filter('a').eq(0).delay(200).animate({ opacity: 'toggle'}, 600);"
      end


      # links 
      if slide.link_2_slide_direction == "top" 
        trans += "children.filter('a').eq(1).css({'top': '-100','left': #{slide.link_2_left.to_i}});"
        trans += "children.filter('a').eq(1).delay(200).animate({ #{slide.link_2_slide_direction}: #{slide.link_2_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_2_slide_direction == 'right' 
        trans += "children.filter('a').eq(1).css({'top':#{slide.link_2_top.to_i},'left':300});"
        trans += "children.filter('a').eq(1).delay(200).animate({ left: #{slide.link_2_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_2_slide_direction == 'bottom' 
        trans += "children.filter('a').eq(1).css({'top':500, 'left': #{slide.link_2_left.to_i}});"
        trans += "children.filter('a').eq(1).delay(200).animate({ top: #{slide.link_2_top.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_2_slide_direction == 'left' 
        trans += "children.filter('a').eq(1).css({'top':#{slide.link_2_top.to_i},'left':-300});"
        trans += "children.filter('a').eq(1).delay(200).animate({ left: #{slide.link_2_left.to_i}, opacity: 'toggle'}, 600);"
      end

      if slide.link_2_slide_direction == 'none' 
        trans += "children.filter('a').eq(1).css({'top':#{slide.link_2_top.to_i},'left':#{slide.link_2_left.to_i}});"
        trans += "children.filter('a').eq(1).delay(200).animate({opacity: 'toggle'}, 600);"
      end
    html += trans
    html.html_safe
  end
end
