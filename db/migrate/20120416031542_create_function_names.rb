class CreateFunctionNames < ActiveRecord::Migration
  def change
    create_table :function_names do |t|
    	t.string  :category
		t.string  :name
      	t.timestamps
    end
  end
end
