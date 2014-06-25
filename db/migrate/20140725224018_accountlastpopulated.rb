class Accountlastpopulated < ActiveRecord::Migration
  def up
    add_column :accounts, :lastrun, :datetime
  end
  def down
    remove_column :accounts, :lastrun
  end
end
