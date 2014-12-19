class AddKeywordsToGroups < ActiveRecord::Migration
  def change
    add_column :groups , :keywords , :text
  end
end
