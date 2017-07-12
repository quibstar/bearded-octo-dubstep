module CopiesHelper

  def split_content(content, url)
    text = ""
    content.split("\n").each_with_index do |t, i|
      if i == 0
        t.sub!("{Keyword:", "")
        t.sub!("}", "")
        text << "<div class='google-ad-header'>#{t}</div><div class='ads-visurl'><span class='ad-circle'>Ad</span>#{url}</div>"
      else
        text << "<div>#{t}</div>"
      end
    end
    text.html_safe
  end

  def linkedIn_content(content)
    text = ""
    content.split("\n").each_with_index do |t, i|
      if i == 0
        text << "<h5 class='linkedIn-ad-header'>#{t}</h5>"
      else
        text << "<div>#{t}</div>"
      end
    end
    text.html_safe
  end

  def twitter_content(content)
    text = ""
    content.split("\n").each_with_index do |t, i|
      if i == 0
        text << "<div class='twitter-ad-header'>#{t}</div>"
      else
        text << "<div>#{t}</div>"
      end
    end
    text.html_safe
  end

  def facebook_post_content(content, url)
    text = ""
    content.split("\n").each_with_index do |t, i|
      if i == 0
        text << "<p class='facebook-post-header'>#{t}</p><p class='facebook-post-url'>#{url}</p>"
      else
        text << "<p>#{t}</p>"
      end
    end
    text.html_safe
  end

  def facebook_ad_content(content, url)
    text = ""
    content.split("\n").each_with_index do |t, i|
      if i == 0
        text << "<div class='facebook-ad-header'>#{t}</div><div class='facebook-ad-url'>#{url}</div>"
      else
        text << "<div>#{t}</div>"
      end
    end
    text.html_safe
  end
end
