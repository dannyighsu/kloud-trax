class Addtrackid < ActiveRecord::Migration
  def up
    remove_column :tracks, :filepath
    add_column :tracks, :trackid, :integer
  end
  def down
    add_column :tracks, :filepath, :string
    remove_colun :tracks, :trackid
  end
end
