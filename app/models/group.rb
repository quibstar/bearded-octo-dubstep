class Group < ActiveRecord::Base

  default_scope { order('id ASC') }

  attr_accessor :keywords_only

  belongs_to :topic 
  has_many :copies, :dependent => :destroy
  has_many :keywords

  mount_uploader :image, GroupUploader

end