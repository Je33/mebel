class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :old_price, :price, :text
end