class Audio < ActiveRecord::Base
  
  #has_many :audio_images, :dependent => :destroy
  #has_many :images, :through => :audio_images
  
  # join models and association for categories
  has_many :asset_categories, :as => :categorizable, :dependent => :destroy
  has_many :categories, :through => :asset_categories
  
  validates :title,  :presence => true
  #validates :description,  :presence => true
  validates :audio, :presence => true
  
  
  mount_uploader :audio, AudioUploader
  
  # attr_accessible :artist, :title, :description, :category_ids, :audio


  before_save :update_asset_attributes
  
  private
  
  def update_asset_attributes
    if audio.present? && audio_changed?
      self.content_type = audio.file.content_type
      self.file_size = audio.file.size
    end
  end
end
