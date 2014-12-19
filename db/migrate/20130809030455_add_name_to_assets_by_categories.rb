class AddNameToAssetsByCategories < ActiveRecord::Migration
  def change
    add_column :asset_by_categories, :name, :string
    add_column :asset_by_categories, :fullname,:string
    add_column :asset_by_categories, :email, :string
  end
end
