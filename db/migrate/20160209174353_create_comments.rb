class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :parent_id
      t.timestamps null: false
    end
  end
end
