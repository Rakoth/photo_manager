class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :title
      t.text :description
			t.references :cover
			t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
