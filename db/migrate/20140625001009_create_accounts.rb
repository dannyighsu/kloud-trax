class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :service
      t.string :accountid
      t.string :accountkey

      t.timestamps
    end
  end
end
