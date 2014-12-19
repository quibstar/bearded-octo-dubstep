class Copy < ActiveRecord::Base


  has_many :alternates, class_name: "Copy", foreign_key: "copy_id"
 
  # belongs_to :manager, class_name: "Employee"

  default_scope { order('id ASC') }

  belongs_to :group 
end
