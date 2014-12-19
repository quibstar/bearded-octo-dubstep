class CreateCssClasses < ActiveRecord::Migration
  def change
    create_table :css_classes do |t|
	  t.string 		:css_class
      t.timestamps
    end
  end
end
