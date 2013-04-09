class ProductTexture < ActiveRecord::Base
  attr_accessible :name, :text, :price, :as_img, :kind_main, :kind_opt

  belongs_to :product
  belongs_to :texture

  def price
    super().to_i
  end

end
