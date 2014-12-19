class CreateDocumentImages < ActiveRecord::Migration
  def change
    create_table :document_images do |t|
    	t.references :document 
    	t.references :image
    	t.string  	:image_size
      t.timestamps
    end
  end
end
