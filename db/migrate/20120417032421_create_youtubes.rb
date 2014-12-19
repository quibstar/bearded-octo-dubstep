class CreateYoutubes < ActiveRecord::Migration
  def change
    create_table :youtubes do |t|
  	t.string 	:title
  	t.string  	:youtube_code
    end
  end
end
