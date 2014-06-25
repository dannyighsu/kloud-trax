class Delete < ActiveRecord::Migration
  def change
    drop_table :users
    drop_table :authentications
  end
end
