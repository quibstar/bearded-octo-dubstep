class NavigationBranch < ActiveRecord::Base
	belongs_to :section
	# attr_accessible :navigation_page, :show_parents, :show_children, :number_of_columns
end
