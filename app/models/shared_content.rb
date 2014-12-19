class SharedContent < ActiveRecord::Base
  
  has_many :sections
  validates :title, :presence => true

  # attr_accessible :title
  
end
