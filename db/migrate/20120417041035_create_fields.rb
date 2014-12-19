class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
		t.references :form
		t.string    :field_name
		t.string   	:field_type
		t.text     	:instructions
		t.boolean  	:required, :default => true
    t.timestamps
    end
    add_index :fields, :form_id
  end
end
