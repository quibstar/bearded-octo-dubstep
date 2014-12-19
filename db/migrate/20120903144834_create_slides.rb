class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
    	t.references	:slider
    	t.references	:image
    	t.string	  	:header
      t.integer     :header_width
      t.integer     :header_visible, :default => 1
      t.string      :header_slide_direction
      t.integer     :header_top, :default => 30
      t.integer     :header_left, :default => 30
      t.string      :header_color
      t.integer     :content_visible, :default => 1
      t.text        :content
      t.integer     :content_width
      t.integer     :content_top, :default => 70
      t.integer     :content_left, :default => 30
      t.string      :content_slide_direction
      t.string      :content_color
      t.integer     :link_1_visible, :default => 1
      t.string      :link_1_title
      t.string      :link_1_url
      t.integer     :link_1_top, :default => 100
      t.integer     :link_1_left, :default => 30
      t.string      :link_1_slide_direction
      t.integer     :link_2_visible, :default => 1
      t.string      :link_2_title
      t.integer     :link_2_top, :default => 100
      t.integer     :link_2_left, :default => 100
      t.string      :link_2_url
      t.string      :link_2_slide_direction
      t.timestamps
    end
  end
end
