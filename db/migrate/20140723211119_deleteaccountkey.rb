class Deleteaccountkey < ActiveRecord::Migration
  def up
    remove_column :accounts, :accountkey
  end
  def down
    add_coumn :accounts, :accountkey, string
  end
end
