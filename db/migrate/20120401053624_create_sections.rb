class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
  	t.references 	:page
  	t.integer 		:parent_id, :default => 0
  	t.references 	:publication
  	t.references 	:function
  	t.references 	:shared_content
  	t.references 	:multi_navigation
  	t.references 	:footer
  	t.integer		   :position
  	t.integer 		:location
  	t.string 		  :section_class
  	t.string 		  :extra_class
  	t.string      :column_class
    t.string      :table_class
  	t.string 		  :tab
  	t.string 		  :section_type
  	t.integer     :visible, :default => 1
    t.integer     :post_per_page
    t.timestamps
  end
    add_index :sections, :parent_id
    add_index :sections, :publication_id
    add_index :sections, :shared_content_id
    add_index :sections, :multi_navigation_id
    add_index :sections, :footer_id
  end
end
