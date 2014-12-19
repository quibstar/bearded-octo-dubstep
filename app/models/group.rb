class Group < ActiveRecord::Base

  default_scope { order('id ASC') }

  belongs_to :topic 
  has_many :copies, :dependent => :destroy
end