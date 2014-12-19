class CreateNavigationGroupsSections < ActiveRecord::Migration
  def change
    create_table :navigation_groups_sections do |t|
    t.references	:navigation_group
    t.references	:section
    end
  end
end
