class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
			t.string 		  :title
      t.string      :slug
      t.integer     :post_template
			t.boolean		  :allow_comments, :default => true
			t.boolean		  :comment_status, :default => true
			t.integer 		:duration,  :default => 30
			t.boolean		  :nesting, :default => true
			t.integer 		:nesting_level, :default => 2
			t.boolean		  :show_author, :default => true
			t.boolean		  :notify_author, :default => true
			t.boolean		  :show_categories,  :default => true
			t.references	:footer, :default => 1
			t.integer 		:template_id, :default => 1
			t.boolean 		:facebook, :default => false
			t.boolean 		:twitter, :default => false
			t.boolean 		:google, :default => false
			t.boolean 		:linkedin, :default => false
			t.boolean 		:pinterest, :default => false
      t.timestamps
    end
    add_index :publications, :slug
  end
end
