class CreateAssetByCategories < ActiveRecord::Migration
  def change
    create_table :asset_by_categories do |t|
    	t.references 	:function
    	t.references	:section
    	t.string		:filter
    	t.string		:image_size
        t.boolean       :caption
        t.boolean       :description
        t.string        :title
        t.string        :phone
        t.boolean       :twitter
        t.boolean       :facebook
        t.boolean       :linkedin
        t.boolean       :bio
    	t.timestamps
    end
    add_index :asset_by_categories, [:function_id, :section_id]
  end
end
