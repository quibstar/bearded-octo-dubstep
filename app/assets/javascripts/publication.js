$(document).ready(function() {
	// publication insert comment on comment form
	$('.comment-reply-link').click(function(){
		$
		$('#comments-section').find('li form').hide();
		$('#comments-section').find('li .comment-reply-link').show();

		$('#new_reply_comment').remove();
		$('.comment-reply-link').show();

		token = $("meta[name='csrf-token']").attr("content");
		publicationId = $(this).attr('data-publication');
		postId = $(this).attr('data-post');
		commentId = $(this).attr('data-comment');
		var form = "<form accept-charset=\"UTF-8\" action=\"/comments\" class=\"new_comment\" id=\"new_reply_comment\" method=\"post\">\
								<div style=\"margin:0;padding:0;display:inline\">\
								<input name=\"utf8\" type=\"hidden\" value=\"✓\">\
								<input name=\"authenticity_token\" type=\"hidden\" value="+ token +"></div>\
								<a rel=\"nofollow\" id=\"cancel-comment-reply-link\" class='btn-u'>Cancel Reply</a>\
									<input id=\"comment_publication_id\" name=\"comment[publication_id]\" type=\"hidden\" value=" + publicationId + ">\
									<input id=\"comment_post_id\" name=\"comment[post_id]\" type=\"hidden\" value=" + postId + ">\
									<input id=\"comment_comment_id\" name=\"comment[comment_id]\" type=\"hidden\" value=" + commentId + ">\
									<label for=\"comment_name\">Name</label>\
									<input id=\"comment_name\" name=\"comment[name]\" size=\"30\" type=\"text\">\
									<br>\
									<label for=\"comment_email\">Email</label>\
									<input id=\"comment_email\" name=\"comment[email]\" size=\"30\" type=\"email\">\
									<br>\
									<label for=\"comment_url\">Url</label>\
									<input id=\"comment_url\" name=\"comment[url]\" size=\"30\" type=\"url\">\
									<br>\
									<label for=\"comment_comment\">Comment</label>\
									<textarea cols=\"40\" id=\"comment_comment\" name=\"comment[comment]\" rows=\"5\"></textarea>\
									<br>\
									<input name=\"commit\" type=\"submit\" value=\"Create Comment\" class='btn-u'>\
								</form>";
		$(this).before(form);
		$(this).hide();
		return false
		})
	$('#cancel-comment-reply-link').on("click",function(){
		$(this).closest('form').siblings('.comment-reply-link').show();
		$('#new_reply_comment').remove();
	
	})

	$('#post-author').mouseenter(function(){
		$(this).find('.author-bio').fadeIn();
	}).mouseleave(function(){
		$(this).find('.author-bio').fadeOut();
	});
})