class CreateFlashReviews < ActiveRecord::Migration
  def change
    create_table :flash_reviews do |t|
      t.references  :client
      t.string      :secure_url
      t.timestamps
    end
  end
end
