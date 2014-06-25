class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :owner
      t.string :cloud_service
      t.string :title
      t.string :filepath
      t.string :album_art
      t.string :artist
      t.string :album
      t.boolean :trashed
      t.time :length
      t.text :lyrics

      t.timestamps
    end
  end
end
