class AssetCategory < ActiveRecord::Base

	belongs_to :categorizable, :polymorphic => true
	belongs_to :category

	# attr_accessible :category_id, :image, :video
end
