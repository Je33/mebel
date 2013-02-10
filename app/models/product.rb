class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :old_price, :price, :text

  belongs_to :category
  has_many :photos

end
