class Testimonial < ActiveRecord::Base

  has_and_belongs_to_many :sections
  
  validates :title, :presence => true
  validates :testimonial, :presence => true

end
