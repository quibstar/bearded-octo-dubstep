class Youtube < ActiveRecord::Base
	
	has_and_belongs_to_many :sections
	has_many :asset_categories, :as => :categorizable, :dependent => :destroy
	has_many :categories, :through => :asset_categories

  validates :title,  :presence => true 
end
