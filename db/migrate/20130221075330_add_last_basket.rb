class AddLastBasket < ActiveRecord::Migration
  def change
    add_column :users, :last_basket, :integer
  end
end
