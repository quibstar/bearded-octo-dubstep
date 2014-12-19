class CreateSectionsTestimonials < ActiveRecord::Migration
  def change
    create_table :sections_testimonials,:id => false do |t|
  		t.references :section
  		t.references :testimonial
    end
  end
end
