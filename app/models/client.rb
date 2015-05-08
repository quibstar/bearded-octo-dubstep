class Client < ActiveRecord::Base

  has_many :topics
  has_many :reviews
  
end
