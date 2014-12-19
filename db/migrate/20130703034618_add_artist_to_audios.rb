class AddArtistToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :artist, :string
  end
end
