class Basket < ActiveRecord::Base
  attr_accessible :cnt, :order_id, :product_id
  belongs_to :order
  belongs_to :product
end
