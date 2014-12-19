class CreateSectionsSliders < ActiveRecord::Migration
  def change
    create_table :sections_sliders,:id => false do |t|
  		t.references :section
  		t.references :slider
    end
  end
end
