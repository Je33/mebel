class Order < ActiveRecord::Base
  attr_accessible :city, :floor, :house, :name,
                  :phone, :room, :status, :street,
                  :text, :session, :user_id

  has_many :baskets, :dependent => :destroy

  paginates_per 20

  def cnt
    c = 0
    self.baskets.each do |b|
      c += b.cnt.to_i
    end
    c
  end

  def sum
    p = 0
    self.baskets.each do |b|
      p += b.cnt.to_i * b.product.price.to_f
    end
    p
  end

end
