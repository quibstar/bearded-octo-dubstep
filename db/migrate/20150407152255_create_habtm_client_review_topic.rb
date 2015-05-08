class CreateHabtmClientReviewTopic < ActiveRecord::Migration
  def change
    create_join_table :reviews, :topics
  end
end
