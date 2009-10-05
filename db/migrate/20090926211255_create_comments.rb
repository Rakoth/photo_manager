class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :author
      t.string :author_url
      t.string :author_email
      t.text :content
			t.boolean :spam, :default => false
			#permalink     # the permanent URL for the entry the comment belongs to

			t.string :user_ip
			t.string :user_agent
			t.string :referrer
			
      t.references :photo

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
