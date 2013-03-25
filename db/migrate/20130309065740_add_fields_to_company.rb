class AddFieldsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :email, :string
    add_column :companies, :production, :string
    add_column :companies, :delivery, :text
    add_column :companies, :installation, :text
    add_column :companies, :elevation, :text
  end
end
