class CreateNavigationBranches < ActiveRecord::Migration
  def change
    create_table :navigation_branches do |t|
    	t.integer		:navigation_page
  		t.references	:section
  		t.boolean		:show_parents
  		t.boolean		:show_children
		  t.integer		:number_of_columns
      t.timestamps
    end
  end
end
