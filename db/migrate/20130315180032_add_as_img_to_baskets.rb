class AddAsImgToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :as_img, :integer, :default => 0
  end
end
