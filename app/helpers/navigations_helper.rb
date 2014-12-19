module NavigationsHelper


	#
	# Admin helpers below

   def admin_sub_nav(navigation, id,path,navigation_group,i)
	
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
				
				# create nested url path
				new_path = path +'/'+ p.url_path
				
				# Put first and last on list items
		  		class_name = "class ='first'" if j == 1
		  		class_name = "class ='last'" if j == page_count
	     		class_name = "class=' '" if page_count  == 1
	     		
	     		
	     		
		  		# place in ordered list
		  		ordered_list_start = "<ol id='admin_nav_#{navigation_group}' class='sub_nav sub_nav_#{i}'>" if j == 1
		  		# close ordered list
		  		ordered_list_end = "</ol>" if j == page_count
	     		
	     		
	     		# increment, must be after 'ordered_list_start' and 'ordered_list_start' or lists will break
	     		j += 1
	     		
	 			# create list items 	
				content = "#{ordered_list_start}<li #{class_name} "
	  		content += "id='page_" + p.id.to_s + "'"
	  		content += " data-parent_id=" + p.parent_id.to_s 
	  		content += " data-navigation=" + p.navigation_id.to_s 
	  		content += " data-position=" + p.position.to_s + "><div class='list-wrap well'>"
	  		content += "<i class='item-icon fontello-icon-move'></i>"
	  		content += p.title
	  		unless p.navigation_text.blank?
					content += " | Link text: #{p.navigation_text} "
				end
	  		content += " <div class='btn-group'>"
	  		content += link_to content_tag(:i,'',:class=> 'fontello-icon-article') + " Content", admin_page_sections_path(p.id), :class=> 'btn btn-mini btn-sky '
	  		content += link_to content_tag(:i,'',:class=> 'fontello-icon-popup-3') + " Create subpage", new_admin_page_path(:parent_id => p.id, :nav_group => p.navigation_id), :class=> 'btn btn-sky btn-mini fboxPages fancybox.ajax'
	  		content += link_to content_tag(:i,'',:class=> 'fontello-icon-cog') + " Page settings", edit_admin_page_path(p.id, :parent_id => p.parent_id,), :class=> 'btn btn-mini btn-yellow fboxPages fancybox.ajax'
	  		if p.published == true
	  			content += link_to content_tag(:i,'',:class=> 'fontello-icon-link-1') + " View", "/#{p.url_path}",:target => '_blank', :class=> 'btn btn-sky btn-mini'
	  		end
	  		content += link_to content_tag(:i,'',:class => ' fontello-icon-trash-4') + " Delete", admin_page_path(p.id), :data => {:data => {:confirm => 'Are you sure?'}}, :method => :delete, :class => 'delete', :class => 'btn btn-redlight btn-mini'
	  		content += '</div>'
	  		content += " <span class='published'>Published: " + status_tag(p.published) + "</span>"
	  		content += " <span class='show-in-nav'>Show in nav: " + status_tag(p.show_in_nav)+ "</span>"
	  		content += " <span class='show-in-mobile'>Show in mobile navigation: " + status_tag(p.mobile)+ "</span>"
	  		content += "</div>"
				# if there are sub pages creat them
		  		unless admin_sub_nav( navigation, p.id,path,navigation_group,i).nil?
		  			content += admin_sub_nav(navigation,p.id,new_path,navigation_group,i)
		  		end
				content += "</li>#{ordered_list_end}"
				nav += content  
			end				
		end
		nav.html_safe
	end


end
