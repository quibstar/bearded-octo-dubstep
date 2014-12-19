class CreateImageSizes < ActiveRecord::Migration
  def change
    create_table :image_sizes do |t|
	t.string  :size
	t.string  :size_value
      t.timestamps
    end
  end
end
