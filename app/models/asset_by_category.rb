class AssetByCategory < ActiveRecord::Base
  belongs_to :section

  # attr_accessible :function_id, :name, :filter, :image_size, :caption, :description, :fullname, :title,:email, :phone, :twitter, :facebook, :linkedin, :bio
end
