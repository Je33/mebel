class AddCompanyToProduct < ActiveRecord::Migration
  def change
    remove_column :categories, :company_id
  end
end
