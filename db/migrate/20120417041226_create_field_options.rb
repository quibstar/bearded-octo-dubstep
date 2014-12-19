class CreateFieldOptions < ActiveRecord::Migration
  def change
    create_table :field_options do |t|
		t.references    :field
		t.string 	      :option
		t.string	      :option_value
		t.boolean       :selected, :default => false
    t.timestamps
    end
    # add_index :Field_options, :field_id
  end
end
