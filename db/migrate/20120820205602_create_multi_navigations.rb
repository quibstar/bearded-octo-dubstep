class CreateMultiNavigations < ActiveRecord::Migration
  def change
    create_table :multi_navigations do |t|
    	t.string 	:title
    	t.boolean 	:show_sub_pages, :default => true
    	t.integer 	:sub_pages_location
    	t.string 	:sub_nav_width
    	t.string  	:dynamic_content_width
      t.timestamps
    end
  end
end
