class CreateNotesPages < ActiveRecord::Migration
  def change
    create_table :notes_pages do |t|
      t.references :note
      t.references :page
    end
  end
end
