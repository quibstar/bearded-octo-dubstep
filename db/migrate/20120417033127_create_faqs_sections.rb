class CreateFaqsSections < ActiveRecord::Migration
  def change
    create_table :faqs_sections,:id => false do |t|
  	t.references :section
  	t.references :faq
    end
  end
end
