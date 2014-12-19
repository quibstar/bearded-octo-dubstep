class CreateAssetCategories < ActiveRecord::Migration
  def change
    create_table :asset_categories do |t|
      t.string :categorizable_type
      t.integer :categorizable_id
      t.integer :category_id
      t.timestamps
    end
  end
end
