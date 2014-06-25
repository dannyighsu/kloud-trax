class Addrelationships < ActiveRecord::Migration
  def up
    add_reference :accounts, :user, index: true
    add_reference :playlists, :user, index: true
    add_reference :tracks, :account, index: true
    add_reference :directories, :account, index: true
    add_reference :tracks, :directory, index: true

    create_join_table :tracks, :playlists do |t|
      t.index [:track_id, :playlist_id]
    end

    remove_column :tracks, :owner
    remove_column :tracks, :cloud_service
    remove_column :directories, :service

  end

  def down
    remove_reference :accounts, :users, index: true
    remove_reference :playlists, :users, index: true
    remove_reference :tracks, :accounts, index: true
    remove_reference :directories, :accounts, index: true
    remove_reference :tracks, :directories, index: true

    drop_join_table :tracks, :playlists

    add_column :tracks, :owner
    add_column :tracks, :cloud_service
    add_column :directories, :service

  end
end
