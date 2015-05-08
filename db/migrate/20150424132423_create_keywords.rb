class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :group
      t.string :word
      t.integer :is_chosen, :default => 0
      t.integer :under_review, :default => 0
      t.column :keyword_id, :bigint
      t.column :ad_group_id, :bigint
      t.timestamps
    end
  end
end
