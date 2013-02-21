class Photo < ActiveRecord::Base
  attr_accessible :product_id, :file

  belongs_to :product

  has_attached_file :file, :styles => {:s => '100x100#', :m => '188x150#'}

end
