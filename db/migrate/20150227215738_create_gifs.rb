class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string      :title
      t.string      :width
      t.string      :height
      t.string      :destination_url
      t.string      :gif
      t.timestamps
    end
  end
end
