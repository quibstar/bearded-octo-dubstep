class Collection < ActiveRecord::Base
  # serialize :settings, ActiveRecord::Coders::Hstore
  # attr_accessible :settings, :title,:category_ids

  has_and_belongs_to_many :sections
  
  # join models and association for categories
  has_many :asset_categories, :as => :categorizable, :dependent => :destroy
  has_many :categories, :through => :asset_categories 

end
