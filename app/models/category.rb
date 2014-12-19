class Category < ActiveRecord::Base
  extend FriendlyId
    friendly_id :name, use: :slugged

	validates :name,  :presence => true
	
  # join models and association for categories
  has_many :asset_categories, :dependent => :destroy
  has_many :images, :through => :asset_categories, :source => :categorizable, :source_type => 'Image'
  has_many :documents, :through => :asset_categories, :source => :categorizable, :source_type => 'Document'
  has_many :audios, :through => :asset_categories, :source => :categorizable, :source_type => 'Audio'
  has_many :videos, :through => :asset_categories, :source => :categorizable, :source_type => 'Video'
  has_many :youtubes, :through => :asset_categories, :source => :categorizable, :source_type => 'Youtube'
  has_many :users, :through => :asset_categories, :source => :categorizable, :source_type => 'User'
  has_many :links, :through => :asset_categories, :source => :categorizable, :source_type => 'Link'
  has_many :posts, :through => :asset_categories, :source => :categorizable, :source_type => 'Post'
  has_many :articles, :through => :asset_categories, :source => :categorizable, :source_type => 'Article'
  has_many :contents, :through => :asset_categories, :source => :categorizable, :source_type => 'Content'
  has_many :collections, :through => :asset_categories, :source => :categorizable, :source_type => 'Collection'
	
  # attr_accessible :name, :image, :document, :audio, :user, :post, :video, :youtube

end
