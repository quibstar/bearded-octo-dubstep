class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string      :title
      t.text        :content
      t.references  :user
      t.string      :reference
      t.timestamps
    end
  end
end
