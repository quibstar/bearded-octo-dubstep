class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
			t.string 		:name
			t.string 		:icon
			t.string 		:share_code
      t.timestamps
    end
  end
end
