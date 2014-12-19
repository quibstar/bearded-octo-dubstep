class PostsController < ApplicationController
	
	def index
    	if params[:post].present?
				@post = Post.find(params[:post])
				redirect_to edit_publication_post_url(@post.publication_id,@post)
			else
				@publication = Publication.find(params[:publication_id])
				@posts = @publication.posts.page(params[:page]).per(25).order('created_at DESC')
				@title = "#{@publication.title} posts"
			end
	end
	
	def show
		if Post.friendly.find(params[:id])
			@post = Post.friendly.find(params[:id])
			post_contents

		elsif Post.find_by_id(params[:id])
			@post =  Post.find_by_id(params[:id])
			post_contents

		else
			not_found_404
			redirect_to '/404'
		end
	end
	
	def category
		if Category.find_by_slug(params[:id])
			@category = Category.friendly.find(params[:id])
			@posts = @category.posts.page(params[:page]).per(20)	
			@publication = Publication.friendly.find(params[:publication_id])
			@sections = @publication.sections.where(:visible => true)	
			@footer = Section.where(:footer_id => @publication.footer_id, :visible => true).order('sections.position ASC')
		else
			not_found_404
			redirect_to '/404'
		end

	end
	


	private

	def post_contents
			@publication = @post.publication	
			@title = @post.title.capitalize
	 		@footer = Section.where(:footer_id => @publication.footer_id, :visible => 1).order('sections.position ASC')
	 		@sections = @publication.sections.where(:visible => 1)
	end
	

	
end
