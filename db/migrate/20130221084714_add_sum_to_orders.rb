class AddSumToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :summ, :float
  end
end
