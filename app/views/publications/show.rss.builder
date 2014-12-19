xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @publication.title
    xml.description @publication.title
    xml.link publication_posts_path(@publication)

    for post in @publication.posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link publication_post_path(@publication, post.id)
        xml.guid publication_post_path(@publication, post.id)
      end
    end
  end
end