class CreateCopies < ActiveRecord::Migration
  def change
    create_table :copies do |t|
      t.text        :content
      t.belongs_to  :group
      t.string      :for_network
      t.timestamps
    end
  end
end
