class AddSettingsToSections < ActiveRecord::Migration
  def change
   add_column :sections,  :settings, :hstore
  end
end
