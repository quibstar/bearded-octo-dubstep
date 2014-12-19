class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
    t.integer :help_category_id
    t.string 	:title
    t.string	:video
    t.text		:content
      t.timestamps
    end
  end
end
