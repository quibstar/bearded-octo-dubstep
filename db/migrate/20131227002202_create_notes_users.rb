class CreateNotesUsers < ActiveRecord::Migration
  def change
    create_table :notes_users do |t|
      t.references :note 
      t.references :user
    end
  end
end
