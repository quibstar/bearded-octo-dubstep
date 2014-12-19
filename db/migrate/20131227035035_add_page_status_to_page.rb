class AddPageStatusToPage < ActiveRecord::Migration
  def change
    add_column :pages, :content_status, :integer
  end
end
