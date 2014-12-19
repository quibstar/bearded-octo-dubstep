class Slide < ActiveRecord::Base

	belongs_to :slider
	belongs_to :image

	# attr_accessible :image_id, :slider_id, :header_visible, :header_slide_direction, :header, :header_color, :header_width, 
	# :header_top, :header_left, :content_visible, :content_slide_direction, :content, :content_color, 
	# :content_width, :content_top, :content_left, :link_1_visible, :link_1_slide_direction, :link_1_title, 
	# :link_1_url, :link_1_top, :link_1_left, :link_2_visible, :link_2_slide_direction, :link_2_title, 
	# :link_2_url, :link_2_top, :link_2_left


end
