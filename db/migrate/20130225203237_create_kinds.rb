class CreateKinds < ActiveRecord::Migration
  def change
    remove_attachment :textures, :photo
    create_table :kinds do |t|
      t.integer :texture_id

      t.timestamps
    end
    remove_column :textures, :price
    remove_column :textures, :type_id
    add_column :product_textures, :price, :integer
    add_column :product_textures, :as_img, :integer
    add_attachment :kinds, :photo
  end
end
