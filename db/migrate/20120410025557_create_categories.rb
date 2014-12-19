class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
		t.string  	:name
		t.integer	:image
		t.integer	:post
		t.integer	:audio
		t.integer	:document
		t.integer	:video
		t.integer 	:user
    t.string :slug
      t.timestamps
    end
  end
end
