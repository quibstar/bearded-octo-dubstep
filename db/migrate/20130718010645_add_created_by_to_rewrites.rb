class AddCreatedByToRewrites < ActiveRecord::Migration
  def change
    add_column :rewrites, :created_by, :string, :default => 'System'
  end
end
