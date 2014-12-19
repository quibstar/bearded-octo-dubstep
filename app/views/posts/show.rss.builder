xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @post.title
    xml.description @post.title
    xml.link publication_posts_path(@publication,@post)

    for comment in @post.comments
      xml.item do
        xml.title comment.name
        xml.description comment.comment
        xml.pubDate comment.created_at.to_s(:rfc822)
        xml.link publication_post_path(@publication, @post)
        xml.guid publication_post_path(@publication, @post)
      end
    end
  end
end