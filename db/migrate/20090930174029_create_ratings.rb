class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :value
      t.references :photo
      t.string :user_ip
      t.string :user_agent
      t.datetime :created_at
    end

		add_index(:ratings, :photo_id)
  end

  def self.down
    drop_table :ratings
  end
end
