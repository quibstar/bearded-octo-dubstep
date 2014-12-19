class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string    :title
      t.string    :recipient
      t.text      :description
      t.text	  :confirmation
      t.timestamps
    end
  end
end
