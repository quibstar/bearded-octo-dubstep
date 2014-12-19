class CreateNavigations < ActiveRecord::Migration
  def change
    create_table :navigations do |t|
		t.string 	:nav_group
		t.text 		:description
      t.timestamps
    end
  end
end
