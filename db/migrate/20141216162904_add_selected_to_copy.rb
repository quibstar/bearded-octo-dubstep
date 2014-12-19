class AddSelectedToCopy < ActiveRecord::Migration
  def change
    add_column :copies, :selected, :boolean, :default => false
    add_column :copies, :copy_id, :integer, :default => false
    add_column :copies, :editor, :string
  end
end
