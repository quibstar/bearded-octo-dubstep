class CreateFlashReviewsSwfs < ActiveRecord::Migration
  def change
    create_table :flash_reviews_swfs, :id => false do |t|
      t.references  :flash_review
      t.references  :swf
    end
  end
end
