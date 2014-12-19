class Function < ActiveRecord::Base
	has_one :asset_by_category
	# accepts_nested_attributes_for :asset_by_category
	
	belongs_to :section
end
