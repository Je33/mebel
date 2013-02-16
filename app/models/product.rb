class Product < ActiveRecord::Base

  attr_accessible :category_id, :name, :old_price, :price, :text, :texture_ids

  scope :sales, where("old_price > 0")
  scope :news, order("created_at desc")

  belongs_to :company
  belongs_to :category
  has_many :photos

  has_many :product_textures
  has_many :textures, :through => :product_textures

end
