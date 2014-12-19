class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text        :response
      t.references  :user
      t.references  :note
    end
  end
end
