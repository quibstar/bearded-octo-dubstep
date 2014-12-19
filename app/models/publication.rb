class Publication < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged

	has_paper_trail :on => [:update, :destroy]
	
	has_many :posts
	
	has_many :sections
	
	has_and_belongs_to_many :networks
	
	validates :title,  :presence => true 
	

	# attr_accessible :title, :allow_comments, :duration, :nesting, :nesting_level, :notify_author, :template_id, :footer_id, :facebook, :twitter, :google, :linkedin, :pinterest, :network_ids, :comment_status, :post_template, :show_author, :show_categories, :slug, :post_template

end
