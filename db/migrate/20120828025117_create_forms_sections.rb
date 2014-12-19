class CreateFormsSections < ActiveRecord::Migration
  def change
    create_table :forms_sections do |t|
    t.references	:form
    t.references	:section
    end
  end
end
