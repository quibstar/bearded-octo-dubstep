# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/assets/documents/"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  #Create different versions of your uploaded files:
  # located in config/initializers


  # DOCUMENT_THUMBNAIL_WIDTH = 50
  # DOCUMENT_THUMBNAIL_HEIGHT = 50
  # DOCUMENT_SMALL_IMAGE_WIDTH = 150
  # DOCUMENT_SMALL_IMAGE_HEIGHT = 150

  # version :thumb, :if => :pdf? do
  #   process :resize_to_fill => [DOCUMENT_THUMBNAIL_WIDTH, DOCUMENT_THUMBNAIL_HEIGHT, Magick::NorthGravity]
  #   process :convert => 'png'
  #   process :paper_shape    
  #   process :convert =>  'png'
  #   def full_filename (for_file = model.logo.file)
  #     super.chomp(File.extname(super)) + '.png'
  #   end
  # end

  # version :small, :if => :pdf? do
  #   process :resize_to_fill => [DOCUMENT_SMALL_IMAGE_WIDTH, DOCUMENT_SMALL_IMAGE_HEIGHT, Magick::NorthGravity]
  #   process :convert => 'png'
  #   process :paper_shape    
  #   process :convert =>  'png'
  #   def full_filename (for_file = model.logo.file)
  #     super.chomp(File.extname(super)) + '.png'
  #   end
  # end
  # def paper_shape
  #    manipulate! do |img|
  #      if img.rows*4 != img.columns*3
  #        width=img.columns
  #        height=img.columns/3*4
  #        img.crop!(0,0,width,height,true)
  #      else
  #        img
  #      end
  #    end
  #  end
  # def cover 
  #   manipulate! do |frame, index|
  #     frame if index.zero?
  #   end
  # end  

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(pdf)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  protected
  def pdf?(new_file)
    new_file.content_type.include? 'pdf'
  end

end
