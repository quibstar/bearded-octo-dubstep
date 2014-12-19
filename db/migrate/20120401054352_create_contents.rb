class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references	 :section
      t.text 		     :content
      t.timestamps
    end
    add_index :contents, :section_id
  end
end
