class CreateCollectionsSections < ActiveRecord::Migration
  def change
    create_table :collections_sections,:id => false do |t|
      t.references :section
      t.references :collection
    end
  end
end
