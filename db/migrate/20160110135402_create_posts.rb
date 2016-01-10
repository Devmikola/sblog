class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title, limit: 240
      t.string :text, limit: 860

      t.timestamps
    end
  end
end
