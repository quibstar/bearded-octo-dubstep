class DocumentImage < ActiveRecord::Base
	belongs_to 	:document
	belongs_to	:image
	# attr_accessible :image_id, :document_id, :image_size
end
