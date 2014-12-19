class AddRedirectToPage < ActiveRecord::Migration
  def change
    add_column :pages, :redirect, :integer
  end
end
