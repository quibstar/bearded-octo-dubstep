class Admin::PostsController < ApplicationController

	before_filter :authenticate_user!, :except => [:index,:show,:category]
	before_filter :post_params, :only => :create
	layout 'admin/admin'
	
	def index
    	if params[:post].present?
				@post = Post.find(params[:post])
				redirect_to edit_publication_post_url(@post.publication_id,@post)
			else
				@publication = Publication.friendly.find(params[:publication_id])
				@posts = @publication.posts.page(params[:page]).per(25).order('created_at DESC')
				@title = "#{@publication.title} posts"
			end
	end
	
	def new
		@publication = Publication.friendly.find(params[:publication_id])
		@post = Post.new
		
		respond_to do |format|
		  format.html
		  format.js
		end
	end

	def create
		params[:post][:category_ids] ||= []
		@post = Post.new(params[:post])
		# params[:post][:publication_id] = params[:publication_id]
		if @post.save 
			# @post.update_attribute(:publication_id, params[:publication_id])
			flash[:success]= "Successfully created post."
			redirect_to admin_publications_path
		else 
			@title = "New Post"
			@publication = Publication.friendly.find(params[:publication_id])
			render :action => 'new'
		end
	end

	def edit
		#@publication = Publication.find(params[:publication_id])
		@post = Post.friendly.find(params[:id])
		@publication = Publication.friendly.find(@post.publication_id)
		@title = @post.title
	end	
	
	def update 
		params[:post][:category_ids] ||= []
		@post = Post.friendly.find(params[:id])

		#add to rewrite table
		if params[:post][:title]
			if @post.slug != params[:post][:title].parameterize
				rewrite = Rewrite.new
				rewrite.request_path = @post.slug
				rewrite.target_path = params[:post][:title].parameterize
				rewrite.post_id = @post.id
				rewrite.save
			end
		end

		if @post.update_attributes(post_params)
			
			flash[:success]= "Successfully updated post."
			redirect_to edit_admin_publication_post_path(@post.publication_id,@post)
		else
			render :action => 'edit'
			@title = "New post"
		end
	end

	def destroy
		post = Post.friendly.find(params[:id])
		publication = post.publication_id
		post.destroy
		redirect_to admin_publication_posts_path(post.publication_id)
	end

	def featured_image
	 	@post = Post.friendly.find(params[:id])
		render :layout => false
	end
	
	private

	def post_contents
			@publication = @post.publication	
			@title = @post.title.capitalize
	 		@footer = Section.where(:footer_id => @publication.footer_id, :visible => 1).order('sections.position ASC')
	 		@sections = @publication.sections.where(:visible => 1)
	end
	
	def post_params
		params.require(:post).permit!
	end
	
end
