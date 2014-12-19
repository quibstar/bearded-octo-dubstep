class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
    	t.references	:section
    	t.string  		:icon_size
    	t.string		:facebook
    	t.string		:twitter
    	t.string		:youtube
    	t.string		:linkedin
    	t.string		:pinterest
    	t.string		:rss
      t.timestamps
    end
  end
end
