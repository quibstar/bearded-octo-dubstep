class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
			t.references  :publication
			t.references  :user
			t.string 		  :title
			t.text 			  :body
			t.boolean		  :published, :defalut => true
			t.boolean   	:comments_open, :default => true
			t.boolean		  :event, :default => false
			t.date  		  :start_date		
			t.date 			  :end_date
			t.boolean		  :show_date, :default => true
			t.boolean		  :show_time, :default => true
			t.time  		  :start_time
			t.time  		  :end_time
			t.string 		  :external_link
			t.string		  :source
			t.boolean 		:show_author
			t.string     	:slug

      t.timestamps
    end
    add_index :posts, [:publication_id, :user_id, :slug]
  end
end
