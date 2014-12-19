class Form < ActiveRecord::Base

  has_many :fields, :dependent => :destroy
  accepts_nested_attributes_for :fields, :allow_destroy => true #,:reject_if => lambda { |attributes| attributes[:form_name].blank? }
  
  # attr_accessible :fields_attributes, :title, :recipient, :description, :confirmation

  validates :title,  :presence => true
  validates :recipient,  :presence => true
  validates :description, :presence => true
  validates :confirmation, :presence => true
end
