class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :posts, :users
    add_foreign_key :images, :posts
    add_foreign_key :comments, :posts
  end
end
