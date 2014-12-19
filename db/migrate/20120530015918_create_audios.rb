class CreateAudios < ActiveRecord::Migration
  def change
	create_table :audios do |t|
	t.string 	:title
	t.text 	    :description
	t.string  	:audio
	t.string  :content_type
	t.string  :file_size
	t.timestamps
    end
  end
end
