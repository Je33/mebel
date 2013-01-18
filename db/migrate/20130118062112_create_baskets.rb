class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :cnt

      t.timestamps
    end
  end
end
