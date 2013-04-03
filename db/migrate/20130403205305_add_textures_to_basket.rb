class AddTexturesToBasket < ActiveRecord::Migration
  def change
    add_column :baskets, :texture_main, :integer
    add_column :baskets, :texture_opt, :integer
  end
end
