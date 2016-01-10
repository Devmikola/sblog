class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :parent_id, null: true
      t.integer :post_id
      t.integer :user_id

      t.string :text, limit: 860

      t.timestamps
    end
  end
end
