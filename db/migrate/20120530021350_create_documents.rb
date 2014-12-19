class CreateDocuments < ActiveRecord::Migration
  def change
	create_table :documents do |t|
	t.string 	:title
	t.text 	    :description
	t.string  	:document
	t.string  :content_type
	t.string  :file_size
	t.timestamps
    end
  end
end
