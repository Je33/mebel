class AddOriginalToProducts < ActiveRecord::Migration
  def change
    add_column :products, :original, :string
  end
end
