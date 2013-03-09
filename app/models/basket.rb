class Basket < ActiveRecord::Base
  attr_accessible :cnt, :order_id, :product_id, :price, :kind_main, :kind_opt
  belongs_to :order
  belongs_to :product

  after_create :count_basket
  after_update :count_basket
  after_destroy :count_basket

  def count_basket
    s = 0
    n = 0
    order = self.order
    order.baskets.includes(:product).each do |b|
      c = b.cnt.to_i > 0 ? b.cnt.to_i : 1
      s += b.product.price.to_f * c
      n += c
    end
    order.update_attribute :summ, s
  end

end
