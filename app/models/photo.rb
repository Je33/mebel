class Photo < ActiveRecord::Base
  attr_accessible :product_id, :file

  belongs_to :product

  has_attached_file :file,
                    :styles => {:s => '100x100', :m => '188x150', :x => '360x270'},
                    :path => "/:class/:attachment/:id_partition/:style/:filename"

end
