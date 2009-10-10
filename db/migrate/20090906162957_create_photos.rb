class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :description
      t.references :album
			t.datetime :deleted_at
			t.integer :comments_count, :default => 0
			t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
