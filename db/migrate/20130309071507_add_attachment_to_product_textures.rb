class AddAttachmentToProductTextures < ActiveRecord::Migration
  def change
    add_attachment :product_textures, :photo
  end
end
