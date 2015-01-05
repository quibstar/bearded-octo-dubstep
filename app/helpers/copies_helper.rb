module CopiesHelper

  def split_content(content, url)
    text = ""
    content.split("\n").each_with_index do |t, i|
      if i == 0
        t.delete! '{}'
        t.delete! '{Keyword:'
        text << "<div class='google-ad-header'>#{t}</div><div class='ads-visurl'>#{url}</div>"
      else
        text << "<div>#{t}</div>"
      end
    end
    text.html_safe 
  end
end
