class CreateSharedContents < ActiveRecord::Migration
  def change
    create_table :shared_contents do |t|
    t.string 	:title
	t.text 	    :content 
      t.timestamps
    end
  end
end
