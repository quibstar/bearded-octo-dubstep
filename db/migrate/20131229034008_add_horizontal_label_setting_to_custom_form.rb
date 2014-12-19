class AddHorizontalLabelSettingToCustomForm < ActiveRecord::Migration
  def change
    add_column :forms , :horizontal , :boolean
  end
end
