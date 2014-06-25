class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :service
      t.string :filepath
      t.boolean :excluded

      t.timestamps
    end
  end
end
