class CreateHelpCategories < ActiveRecord::Migration
  def change
    create_table :help_categories do |t|
    t.string 	:title
    end
  end
end
