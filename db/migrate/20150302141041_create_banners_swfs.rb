class CreateBannersSwfs < ActiveRecord::Migration
  def change
    create_table :banners_swfs, :id => false  do |t|
      t.references  :banner
      t.references  :swf
    end
  end
end
