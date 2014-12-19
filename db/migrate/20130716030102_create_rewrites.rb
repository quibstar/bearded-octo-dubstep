class CreateRewrites < ActiveRecord::Migration
  def change
    create_table :rewrites do |t|
      t.integer :page_id
      t.integer :post_id
      t.string :request_path
      t.string :target_path

      t.timestamps
    end
    add_index :rewrites , :request_path
  end
end
