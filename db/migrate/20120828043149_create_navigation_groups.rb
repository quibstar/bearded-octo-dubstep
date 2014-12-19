class CreateNavigationGroups < ActiveRecord::Migration
  def change
    create_table :navigation_groups do |t|
    t.references	:navigation
    t.references	:section
    t.string		  :orientation
      t.timestamps
    end
  end
end
