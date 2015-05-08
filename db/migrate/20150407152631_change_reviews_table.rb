class ChangeReviewsTable < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      # t.remove :topic_id, :user, :viewed
      t.integer :client_id
    end
  end
end
