class AddToSwf < ActiveRecord::Migration
  def change
    remove_column :swfs, :ad_layout
    remove_column :swfs, :custom_width_height
    remove_column :swfs, :file_size
    add_column    :swfs, :distination_url, :string
  end
end
