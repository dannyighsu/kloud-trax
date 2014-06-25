class Trackid < ActiveRecord::Migration
  def up
    change_column :tracks, :trackid, :string
  end
  def down
    change_column :tracks, :trackid, :integer
  end
end
