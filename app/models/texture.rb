class Texture < ActiveRecord::Base
  attr_accessible :name, :text
  default_scope order("name ASC")

  has_many :kinds

  has_many :product_textures, :dependent => :destroy
  has_many :products, :through => :product_textures

  #has_attached_file :photo, :styles => {:s => '50x50#', :m => '300x300'}

end
