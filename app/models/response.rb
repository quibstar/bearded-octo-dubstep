class Response < ActiveRecord::Base

  default_scope { order('id ASC') }
  
  belongs_to :note
  belongs_to :user
  
end