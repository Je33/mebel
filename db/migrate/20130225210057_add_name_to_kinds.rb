class AddNameToKinds < ActiveRecord::Migration
  def change
    add_column :kinds, :name, :string
  end
end
