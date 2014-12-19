class Image < ActiveRecord::Base

  before_save :update_image_attributes

  belongs_to :document
  has_one :document_image
  
  
  # post join models and association
  has_many :post_images, :dependent => :destroy
  has_many :posts, :through => :post_images

  has_many :slides
  
	# Categories join models and association for categories
	has_many :asset_categories, :as => :categorizable, :dependent => :destroy
	has_many :categories, :through => :asset_categories 
	  
	validates :title,  :presence => true
	validates :image,  :presence => true

	mount_uploader :image, ImageUploader

	attr_accessor :asset
	attr_accessor :asset_id
	attr_accessor :image_size
	attr_accessor :publication_id

	after_save :set_asset
	after_destroy :check_sliders

	# attr_accessible :title,:image, :caption, :description, :image_cache, :remove_image, 
	# :category_ids, :asset, :asset_id, :publication_id, :image_size, :image_id, :post_id

	private

	def set_asset
		#pre written for images for assets just not used 9-11-2012
		if @asset == "document"
			document = DocumentImage.find_by_document_id(@asset_id)
			if document
				document.update_attributes(:image_id => self.id, :document_id => @asset_id, :image_size => @image_size )
			else
				document = DocumentImage.new
				document.update_attributes(:image_id => self.id, :document_id => @asset_id, :image_size => @image_size )
			end
		end
		# if @asset == "audio"
		# 	audio = AudioImage.find_by_audio_id(@asset_id)
		# 	if audio
		# 		audio.update_attributes(:image_id => self.id, :audio_id => @asset_id, :image_size => @image_size )
		# 	else
		# 		audio = AudioImage.new
		# 		audio.update_attributes(:image_id => self.id, :audio_id => @asset_id, :image_size => @image_size )
		# 	end
		# end
		# if @asset == "video"
		# 	video = VideoImage.find_by_video_id(@asset_id)
		# 	if video
		# 		video.update_attributes(:image_id => self.id, :video_id => @asset_id, :image_size => @image_size )
		# 	else
		# 		video = VideoImage.new
		# 		video.update_attributes(:image_id => self.id, :video_id => @asset_id, :image_size => @image_size )
		# 	end
		# end
		
		if @asset == "post"
			post = PostImage.find_by_post_id(@asset_id)
			if post
				post.update_attributes(:image_id => self.id, :post_id => @asset_id, :image_size => @image_size )
			else
				post = PostImage.new
				post.update_attributes(:image_id => self.id, :post_id => @asset_id, :image_size => @image_size )
			end
		end
	end

	def check_sliders
		slider = Slide.find_by_image_id(self.id)
		if slider
			slider.destroy
		end
	end

 private

  def update_image_attributes
    if image.present? && image_changed?
      self.content_type = image.file.content_type
      self.file_size = image.file.size
    end
  end

end
