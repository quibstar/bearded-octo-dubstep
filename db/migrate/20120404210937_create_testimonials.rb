class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
    	t.text    :title
      t.text    :testimonial
      t.string  :author
      t.string  :position
      t.string  :company
      t.timestamps
    end
  end
end
