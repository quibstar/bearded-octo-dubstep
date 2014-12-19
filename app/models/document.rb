class Document < ActiveRecord::Base
  

  # has_many :document_images, :dependent => :destroy
  # has_many :images, :through => :document_images

  has_one :document_image 
  has_one :image, :through => :document_image
  
  # join models and association for categories
  has_many :asset_categories, :as => :categorizable, :dependent => :destroy
  has_many :categories, :through => :asset_categories 
  
  validates :title,  :presence => true
  #validates :description,  :presence => true
  validates :document, :presence => true
  
  mount_uploader :document, DocumentUploader
  
  before_save :update_asset_attributes
  after_save :set_asset

  # attr_accessible :title, :description, :category_ids, :document,:image_id, :image_size
  
  attr_accessor :image_size
  attr_accessor :image_id

  private
  
  def update_asset_attributes
    if document.present? && document_changed?
      self.content_type = document.file.content_type
      self.file_size = document.file.size
    end
  end
  def set_asset
    document = DocumentImage.find_by_document_id(self.id)
    if document
      document.update_attributes(:image_id => @image_id,:document_id => self.id, :image_size => @image_size )
    else
      document = DocumentImage.new
      document.update_attributes(:image_id => @image_id, :document_id => self.id, :image_size => @image_size )
    end
  end

  # require 'RMagick'
  # after_save :cover_image
  # def cover_image
  #   image_path = "#{Rails.root}/public/uploads/images/"
  #   file = "/Users/krisu/Sites/rails-projects/cheetah-v2/public#{self.document}[0]"
  #   file_name = self.title.gsub!(/ /, '_')

  #   pdf = Magick::ImageList.new(file)
  #   thumb = pdf.resize_to_fit(50,50)
  #   small = pdf.resize_to_fit(150,150)
  #   large = pdf.resize_to_fit(300,300)
  #   original = pdf

  #   thumb.write "#{image_path}thumb_#{file_name}.png"
  #   small.write "#{image_path}small_#{file_name}.png"
  #   large.write "#{image_path}large_#{file_name}.png"
  #   original.write "#{image_path}#{file_name}.png"
  #   image = Image.new(:title => self.title, :image =>  file_name)
  #   image.save!
  # end


end
