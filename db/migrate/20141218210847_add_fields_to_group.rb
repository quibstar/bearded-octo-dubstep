class AddFieldsToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :destination_url, :string
    add_column :groups, :display_url, :string
    add_column :groups, :network, :string
  end
end
