class ProductTexture < ActiveRecord::Base
  attr_accessible :name, :text, :price, :as_img

  belongs_to :product
  belongs_to :texture

end
