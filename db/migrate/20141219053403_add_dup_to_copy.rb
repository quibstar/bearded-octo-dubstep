class AddDupToCopy < ActiveRecord::Migration
  def change
    add_column :copies, :is_duplicate, :string, :default => false
  end
end
