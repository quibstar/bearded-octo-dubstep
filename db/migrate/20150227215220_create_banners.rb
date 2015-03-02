class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.references  :client
      t.string      :secure_url
      t.string      :banner_style
      t.timestamps
    end
  end
end
