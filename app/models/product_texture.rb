class ProductTexture < ActiveRecord::Base
  attr_accessible :name, :text, :type_id

  belongs_to :product
  belongs_to :texture

end
