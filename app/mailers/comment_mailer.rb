class CommentMailer < ActionMailer::Base
  default from: "admin@cheetahcms.com"
  
  def comment_notification(publication, comment, post, user)
  	@publication = publication
    @comment = comment
    @post = post
    @user = user
    mail(:to => user.email, :subject => "A comment needs your approval")
  end
end
