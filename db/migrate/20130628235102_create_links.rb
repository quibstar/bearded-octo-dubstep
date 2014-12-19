class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :link
      t.string :link_title
      t.boolean :new_window

      t.timestamps
    end
  end
end
