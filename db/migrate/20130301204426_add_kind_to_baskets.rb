class AddKindToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :kind_main, :integer
    add_column :baskets, :kind_opt, :integer
    add_column :baskets, :price, :float
  end
end
