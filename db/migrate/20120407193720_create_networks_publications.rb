class CreateNetworksPublications < ActiveRecord::Migration
  def change
    create_table :networks_publications, :id => false do |t|
			t.references	:publication
			t.references	:network
    end
  end
end
