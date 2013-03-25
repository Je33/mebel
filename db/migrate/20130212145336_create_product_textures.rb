class CreateProductTextures < ActiveRecord::Migration
  def change
    create_table :product_textures, :id => false do |t|
      t.integer :product_id
      t.integer :texture_id
      #t.timestamps
    end
  end
end
