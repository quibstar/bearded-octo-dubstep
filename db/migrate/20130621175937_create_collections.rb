class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.hstore :settings
      t.timestamps
    end
  end
end
