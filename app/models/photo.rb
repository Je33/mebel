class Photo < ActiveRecord::Base
  attr_accessible :product_id, :file

  belongs_to :product

  has_attached_file :file, :styles => {:s => '100x100#', :m => '600x600'}

end
