class Post < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged

	has_paper_trail :on => [:update, :destroy]
	 
	belongs_to :publication
	
	#make a function to check for admin or user or ?
	belongs_to :user
	
	has_many :comments, :dependent => :destroy
	
	# join models and association for categories
	has_many :asset_categories, :as => :categorizable, :dependent => :destroy
	has_many :categories, :through => :asset_categories
	
	
	# join model for  images
	has_many :post_images, :dependent => :destroy
	has_many :images, :through => :post_images
	
	belongs_to :image

	validates :title, :presence => true
	validates :body,  :presence => true
	
	# attr_accessible :user_id, :title, :body, :published, :comments_open, :event, :show_date, :start_date, 
	# :end_date, :show_time, :start_time, :end_time, :external_link, :source, :show_author, :image_size, :category_ids, 
	# :image_ids, :publication_id,:start_publishing, :end_publishing
	
	
	# for updateing image size in blog_images
	attr_accessor :image_size
	attr_accessor :mobile_ready
	

  after_save :set_asset

  	def set_asset
  		post = PostImage.find_by_post_id(self.id)
			unless post.nil?
				post.update_attributes(:image_size => @image_size )
			end
  	end

 include PgSearch
  multisearchable :against => [:title, :body]

	
end
