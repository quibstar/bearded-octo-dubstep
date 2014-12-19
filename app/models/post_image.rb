class PostImage < ActiveRecord::Base
	belongs_to 	:post
	belongs_to	:image
	# attr_accessible :image_id, :post_id, :image_size
end
