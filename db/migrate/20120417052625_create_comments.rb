class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    t.references 	:post
    t.string 		:name
    t.string 		:email
    t.string		:url
    t.text   		:comment
    t.integer       :comment_id, :default => 0
    t.boolean		:published, :default => false
    t.timestamps
    end
    add_index :comments, :post_id
  end
end
