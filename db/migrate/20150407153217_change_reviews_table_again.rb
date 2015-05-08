class ChangeReviewsTableAgain < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      # t.integer :topic_id
    end
  end
end
