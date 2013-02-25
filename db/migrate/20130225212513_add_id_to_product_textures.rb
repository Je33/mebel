class AddIdToProductTextures < ActiveRecord::Migration
  def change
    drop_table :product_textures
    create_table :product_textures do |t|
      t.integer :product_id
      t.integer :texture_id
      t.float :price
      t.integer :as_img
      #t.timestamps
    end
  end
end
