class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :text
      t.string :phone
      t.string :city
      t.string :street
      t.string :house
      t.string :floor
      t.string :room
      t.integer :status

      t.timestamps
    end
  end
end
