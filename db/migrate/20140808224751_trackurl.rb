class Trackurl < ActiveRecord::Migration
  def up
    add_column :tracks, :url, :string
  end
  def down
    remove_column :tracks, :url
  end
end
