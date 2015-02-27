class AddToSwfAgain < ActiveRecord::Migration
  def change
    remove_column    :swfs, :distination_url
    add_column    :swfs, :destination_url, :string
  end
end
