class CreateSectionsSharedContents < ActiveRecord::Migration
  def change
    create_table :sections_shared_contents, :id => false do |t|
    	t.references :section
		  t.references :shared_content
    end
  end
end
