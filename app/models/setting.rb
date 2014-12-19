class Setting < ActiveRecord::Base

  attr_accessor :robots


  geocoded_by :address   # can also be an IP address
  after_validation :geocode #,:if => :address_changed? # auto-fetch coordinates

  def address
    [street, city, state, zip].compact.join(', ')
  end
  	mount_uploader :logo, LogoUploader
  	
end
