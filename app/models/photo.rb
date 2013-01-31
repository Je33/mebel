class Photo < ActiveRecord::Base
  attr_accessible :product_id

  belongs_to :product

  has_attached_file :file, :styles => {:s => 'x100', :m => '600x600'}

end
