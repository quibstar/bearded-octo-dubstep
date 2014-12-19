module PostsHelper
  
  # comment in all comment for post
  # comment id is current comment.id
  # nesting level is blog settings nesting levle
  # current_level is for hiding the a tag
  def show_comments(comments, comment_id, post_id, nesting_level, publication_id, current_level)
    content = ''
		@post.comments.where('published = ? AND comment_id = ?', true, comment_id.to_s).each do |c|
		  content += "<div class='comment-wrap level-#{current_level}'>"
			content += "<div class='comment-image pull-left'>"
			content += image_tag avatar_url_large(c.email)
			content += "</div>"
			content += "<div class='comment-content'><div class='comment-header'> <h4>" + c.name
			content += "<small class='pull-right'>Posted: " + distance_of_time_in_words(Time.now, c.created_at) + " ago.</small></h4></div>"
			content += "<div class='content-body'><p id='comment=" + c.id.to_s + "'>" + c.comment
			if nesting_level > current_level
			  content += "</p><a class='comment-reply-link btn-u' data-post=" + post_id.to_s + " data-publication=" + publication_id.to_s + " data-comment=" + c.id.to_s + ">Reply</a>"
			end

      content += "</div></div></div>"

			# if there are sub pages create them
			unless show_comments(comments, c.id, post_id, nesting_level, publication_id, current_level).nil?
			    current_level += 1
			  	content += show_comments(comments, c.id, post_id, nesting_level,publication_id, current_level)
			  end
		end
		content.html_safe
	end


end
