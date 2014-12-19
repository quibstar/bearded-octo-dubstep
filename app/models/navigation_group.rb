class NavigationGroup < ActiveRecord::Base
	belongs_to :section
	# attr_accessible :navigation_id, :orientation
end
