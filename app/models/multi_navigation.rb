class MultiNavigation < ActiveRecord::Base
	has_many :sections
	has_one :page

	validates :title, :presence => true
	validates :dynamic_content_width, :presence => true

	# attr_accessible :title, :show_sub_pages, :sub_pages_location, :sub_nav_width, :dynamic_content_width
end
