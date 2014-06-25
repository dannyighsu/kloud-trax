class Accountkey < ActiveRecord::Migration
  def up
    add_column :accounts, :accountkey, :string
  end
  def down
    remove_column :accounts, :accountkey
  end
end
