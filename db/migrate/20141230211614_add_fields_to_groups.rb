class AddFieldsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :start_date, :string
    add_column :groups, :end_date, :string
    add_column :groups, :image, :string
  end
end
