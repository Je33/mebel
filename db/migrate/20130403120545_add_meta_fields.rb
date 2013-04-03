class AddMetaFields < ActiveRecord::Migration
  def change
    add_column :products, :page_title, :string
    add_column :products, :page_description, :text
    add_column :products, :page_keywords, :text
    add_column :categories, :page_title, :string
    add_column :categories, :page_description, :text
    add_column :categories, :page_keywords, :text
    create_table :settings do |t|
      t.string :name
      t.string :value
    end
  end
end
