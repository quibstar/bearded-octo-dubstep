class AddCanEditToClients < ActiveRecord::Migration
  def change
  	add_column :clients, :can_edit, :boolean, :default => true
  end
end
