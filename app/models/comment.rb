class Comment < ActiveRecord::Base

	has_paper_trail #:on => :update #[:update, :destroy]

	after_create :notify

	belongs_to :post


	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,    :presence => true
	validates :email,   :presence   => true,  :format => { :with => email_regex }
	validates :comment, :presence => true

	attr_accessor :publication_id, :remove, :body
	# attr_accessible :publication_id, :post_id, :published, :comment_id, :name, :email, :url, :body, :comment, :remove


	def notify
		# create function to notify author
		# blog notify_author == true
		# post user_id pull email from user account
		# 
		post = Post.find(self.post_id)
		publication = Publication.find(post.publication_id)
			
		#blog = Blog.find(1)
		if publication.notify_author == true
			@publication = publication
			@comment = Comment.find(self.id)
			@post = post
			@user = User.find(@post.user_id)
			
			#@settings = Setting.find(1)
			CommentMailer.comment_notification(@publication, @comment, @post, @user).deliver
			# rake jobs:work
			#CommentMailer.delay.comment_notification(@comment, @post, @user, @settings)
		end
	end

	end
