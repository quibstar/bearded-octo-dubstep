class AddClientIdToTopics < ActiveRecord::Migration
  def change
     add_column :topics, :client_id, :integer
  end
end
