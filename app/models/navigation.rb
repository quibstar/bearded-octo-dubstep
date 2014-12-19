class Navigation < ActiveRecord::Base
	has_many :pages
	validates :nav_group, :presence => true
  # attr_accessible  :nav_group, :description
end
