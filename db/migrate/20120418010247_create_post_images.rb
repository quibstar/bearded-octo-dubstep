class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.references 	:post
      t.references 	:image
      t.string  	:image_size
      t.timestamps
    end
  end
end
