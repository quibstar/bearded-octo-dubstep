class Footer < ActiveRecord::Base
	has_many :sections	

	# attr_accessible :title
	validates :title,  :presence => true

end
