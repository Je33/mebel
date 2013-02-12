class CreateTextures < ActiveRecord::Migration
  def change
    create_table :textures do |t|
      t.integer :type_id
      t.string :name
      t.text :text
      t.float :price

      t.timestamps
    end
    add_attachment :textures, :photo
  end
end
