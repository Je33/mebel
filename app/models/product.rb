class Product < ActiveRecord::Base

  attr_accessible :category_id, :name, :old_price,
                  :price, :text, :texture_ids, :original,
                  :page_title, :page_description, :page_keywords

  scope :sales, where("old_price > 0")
  scope :news, order("created_at desc")

  belongs_to :company
  belongs_to :category
  has_many :photos, :dependent => :destroy

  paginates_per 20

  has_many :product_textures, :dependent => :destroy
  has_many :textures, :through => :product_textures

  def price
    super().to_i
  end

  def old_price
    super().to_i
  end

end
