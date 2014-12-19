class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references  :template
      t.references  :footer, :default => 1
      t.integer     :parent_id, :default => 0
      t.references  :multi_navigation
      t.references  :slider
      t.integer     :position
      t.string      :title
      t.string      :navigation_text
      t.string      :url_path
      t.integer     :navigation_id
      t.boolean     :published, :default => true
      t.boolean     :show_in_nav, :default => true
      t.text        :keywords
      t.text        :description
      t.boolean     :mobile
      t.timestamps
    end
    add_index :pages, [:parent_id, :slider_id, :multi_navigation_id]
  end
end
