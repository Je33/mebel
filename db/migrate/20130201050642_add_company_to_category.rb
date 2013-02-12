class AddCompanyToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :company_id, :integer
    add_column :products, :company_id, :integer
    add_column :orders, :company_id, :integer
  end
end
