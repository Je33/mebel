class Product < ActiveRecord::Base
  attr_accessible :category_id, :name, :old_price, :price, :text, :texture_ids

  belongs_to :category
  has_many :photos

  has_many :product_textures
  has_many :textures, :through => :product_textures

end
