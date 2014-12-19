class Field < ActiveRecord::Base

  belongs_to :forms
  
  has_many :field_options, :dependent => :destroy
  accepts_nested_attributes_for :field_options, :allow_destroy => true #,:reject_if => lambda { |attributes| attributes['option'].blank? }, :allow_destroy => true
  
  # attr_accessible :field_name,:field_type, :instructions,:required, :field_options_attributes, :option
  
end
