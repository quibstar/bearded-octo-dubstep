class CommentsController < ApplicationController
require 'uri'
  
  def new
    @comment = Comment.new
  end
  
	def create 
		#span hunting
		logger.debug params[:comment][:body].blank?
		if params[:comment][:body].blank?
			@comment = Comment.new(comment_params)
			if @comment.save 
				flash[:success]= "Comment has been submitted."
				redirect_to request.referer 
			else
				redirect_to request.referer 
				flash[:error]= "There was an issue with your comment submission. Did you fill out all the required fields? Please try again."
				@title = "New Comment"
			end
		else
			flash[:success]= "Thank you for that spam."
			redirect_to request.referer 
		end
	end

	def comment_params
		params.require(:comment).permit(:publication_id, :post_id, :published, :comment_id, :name, :email, :url, :body, :comment, :remove)
	end

end
