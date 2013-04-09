class AddTexturesToLink < ActiveRecord::Migration
  def change
    add_column :product_textures, :kind_main, :integer
    add_column :product_textures, :kind_opt, :integer
  end
end
