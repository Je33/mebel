class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :text
      t.integer :cnt

      t.timestamps
    end
  end
end
