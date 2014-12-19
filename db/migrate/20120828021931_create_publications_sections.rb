class CreatePublicationsSections < ActiveRecord::Migration
  def change
    create_table :publications_sections do |t|
    	t.references	:publication
		  t.references	:section
    end
  end
end
