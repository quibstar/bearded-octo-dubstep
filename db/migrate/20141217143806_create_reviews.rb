class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string        :topic_id
      t.string        :url
      t.string        :user
      t.boolean       :viewed, :defautl => false
      t.timestamps    :viewed_at
      t.timestamps
    end
    add_index :reviews, :url
  end
end
