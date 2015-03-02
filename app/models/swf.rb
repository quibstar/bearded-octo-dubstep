class Swf < ActiveRecord::Base
  attr_accessor :flash_review
  has_and_belongs_to_many :flash_reviews


  attr_accessor :banner
  has_and_belongs_to_many :banners

  mount_uploader :swf, SwfUploader
end
