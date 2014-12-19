class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string    :site_title
      t.string 	:tag_line
      t.string 	:url
      t.string    :street
      t.string    :city
      t.string    :state
      t.string    :zip
      t.string    :email
      t.string    :phone
      t.string    :fax
      t.string    :logo
      t.text      :analytics
      t.float     :latitude
      t.float     :longitude
      t.timestamps
    end
  end
end
