class AddPhotosCountToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :photos_count, :integer, :default => 0

		Album.reset_column_information
		Album.all.each do |album|
			Album.update_counters album.id, :photos_count => album.photos.count
		end
  end

  def self.down
    remove_column :albums, :photos_count
  end
end
