class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.references :photo
			t.text :description
      t.datetime :view_at
			
      t.timestamps
    end
  end

  def self.down
    drop_table :purchases
  end
end
