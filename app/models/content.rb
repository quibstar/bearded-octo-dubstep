class Content < ActiveRecord::Base
	
	has_paper_trail :on => [:update, :destroy]
	  	
	belongs_to :section
	
	# attr_accessible :content
	  
  
	# validates_presence_of :content
	

  include PgSearch
  multisearchable :against => :content
end
