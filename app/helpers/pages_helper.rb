module PagesHelper


  #get section name 
  def section_area(id)
	if id == 1
		inputs =''
		inputs += '<ol class="page-section"><li><label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '2'
		inputs += "Main </label>"
		inputs += '</li></ol>'
		inputs.html_safe
	elsif id == 2
		inputs =''
		inputs += '<ol class="page-section"><li><label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '1'
		inputs += "Left Sidebar </label>"
		inputs += '<label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '2'
		inputs += "Main </label>"
		inputs += '</li></ol>'
		inputs.html_safe
	elsif id == 3
		inputs =''
		inputs += '<ol class="page-section"><li><label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '2'
		inputs += "Main </label>"
		inputs += '<label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '3'
		inputs += "Right Sidebar </label>"
		inputs += '</li></ol>'
		inputs.html_safe
	elsif id == 4
		inputs =''
		inputs += '<ol class="page-section"><li><label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '1'
		inputs += "Left Sidebar </label>"
		inputs += '<label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '2'
		inputs += "Main </label>"
		inputs += '<label class="radio inline">'
		inputs += radio_button_tag 'section[location]', '3'
		inputs += "Right Sidebar </label>"
		inputs += '</li></ol>'
		inputs.html_safe
	end
	  
  end
  
	#builds navigation for copying or moving
	def cpmv_sub_nav(navigation, id,i)
		nav = ""
		navigation.each do |p|
				if p.parent_id == id
					content = '<ol><li>'
					content += link_to p.title, "#", :data => {:page => p.id}, :class=>'btn btn-sky btn-mini'

					content += section_area(p.template_id)
					unless cpmv_sub_nav(navigation,p.id,i).nil?
						content << cpmv_sub_nav(navigation, p.id,i)
					end
					content += "</li></ol>"
					nav += content  
				end				
			end
			nav.html_safe
	end
end
