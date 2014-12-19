class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string 	:title
      t.string  :caption
  		t.text 	  :description
  		t.string 	:caption
  		t.string  :image	
      t.string  :content_type
      t.string  :file_size
      t.timestamps
    end
  end
end
