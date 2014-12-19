class CreateSectionsYoutubes < ActiveRecord::Migration
  def change
    create_table :sections_youtubes do |t|
  	t.references :section
  	t.references :youtube
    end
  end
end
