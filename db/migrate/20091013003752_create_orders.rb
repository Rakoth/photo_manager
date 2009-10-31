class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.text :place
      t.text :description
      t.datetime :start_at
      t.datetime :view_at

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
