class CreateSwfs < ActiveRecord::Migration
  def change
    create_table :swfs do |t|
      t.string      :title
      t.string      :ad_layout
      t.boolean     :custom_width_height, :default => false
      t.string      :width
      t.string      :height
      t.string      :file_size
      t.string      :swf
      t.timestamps
    end
  end
end
