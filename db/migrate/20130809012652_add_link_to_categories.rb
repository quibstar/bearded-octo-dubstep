class AddLinkToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :link, :integer
  end
end
