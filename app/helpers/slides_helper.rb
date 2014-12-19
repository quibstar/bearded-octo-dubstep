module SlidesHelper

  def internal_links(navigation, id,i, slide_id)
    nav = ""
    navigation.each do |p|
        if p.parent_id == id
          content = '<ol class="sub-nav"><li>'
          content += link_to p.title, "#", :data => {:page => p.url_path, :slide => slide_id}, :class=>''
          unless internal_links(navigation,p.id,i, slide_id).nil?
            content << internal_links(navigation, p.id,i, slide_id)
          end
          content += "</li></ol>"
          nav += content  
        end       
      end
      nav.html_safe
  end

end

'<i class=" fontello-icon-right-open-1"></i>'

