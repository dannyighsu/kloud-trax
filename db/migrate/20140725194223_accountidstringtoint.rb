class Accountidstringtoint < ActiveRecord::Migration
  def up
    change_column :accounts, :accountid, :integer
  end
  def down
    change_column :accounts, :accountid, :string
  end
end
