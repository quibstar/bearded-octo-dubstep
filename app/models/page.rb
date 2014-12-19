class Page < ActiveRecord::Base
 	
 	has_paper_trail :on => [:update, :destroy]
	acts_as_list
	
	belongs_to 	:navigation
	has_many	:sections
	has_one		:multi_navigation
	has_one		:footer
	belongs_to 	:slider
	
	has_and_belongs_to_many :notes
	
	# validates :title,  :presence => true 
	# validates :template_id,  :presence => true
	# validates :footer_id, :presence => true
	# validates :navigation_id, :presence => true

	
	has_many :sections, :dependent => :destroy
	
	# using paper trail so keep section around if page is restored	
	# accepts_nested_attributes_for :sections, :allow_destroy => true
	 
	# attr_accessible :parent_id, :position, :title, :navigation_text, :navigation_id, :published, 
	# 				:show_in_nav, :keywords, :description, :template_id, :footer_id, :slider_id, 
	# 				:multi_navigation_id, :mobile, :url_path, :redirect

end
