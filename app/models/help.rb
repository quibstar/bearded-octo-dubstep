class Help < ActiveRecord::Base
	has_one :help_category

	# attr_accessible :help_category_id, :title, :content, :video

end
