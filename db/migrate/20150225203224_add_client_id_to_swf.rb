class AddClientIdToSwf < ActiveRecord::Migration
  def change
    add_column :swfs, :client_id, :integer
  end
end
