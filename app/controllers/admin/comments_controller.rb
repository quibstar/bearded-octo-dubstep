class Admin::CommentsController < ApplicationController
  
	before_filter :authenticate_user!,:except => [:new, :create, :show]
  layout 'admin/admin' 

   
  def index 
  	if params[:published] == '0'
  		@comments = Comment.where(:post_id => params[:post_id], :published => false)
  	elsif params[:published] == '1'
  		@comments = Comment.where(:post_id => params[:post_id], :published => true)
  	else
  		@comments = Comment.order(:name)
  	end
  	@publication = Publication.find(params[:publication_id])
    @post = Post.find(params[:post_id])
	
  end
  	
	def edit
		@publication = Publication.find(params[:publication_id])
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@title = "Update Comment"
		
		#authroization
		unauthorized? if cannot? :update, @comment
	end
	
  def status 
    # params.each do |key,value|
    #   Rails.logger.warn "Param #{key}: #{value}"
    # end
    @comment = Comment.find(params[:id])
      if params[:remove] == '1'
        @comment.destroy
        flash[:success]= "Successfully removed comment."
      elsif params[:published] == '0'  
        @comment.update_attributes(:published => false)
        flash[:success]= "Successfully updated comment status to un-published."
      elsif params[:published] == '1'
        @comment.update_attributes(:published => true)
        flash[:success]= "Successfully updated comment status published."
      else
        flash[:error]= "There was an error updating your post please try again."
      end
      redirect_to admin_publication_posts_path(params[:publication_id])
  end
	

end
