class AddIdInPostColumnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :id_in_post, :integer
  end
end
