class Adddirectoryid < ActiveRecord::Migration
  def up
    rename_column :directories, :filepath, :directoryid
  end
  def down
    rename_column :directories, :directoryid, :filepath
  end
end
