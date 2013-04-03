class Special < ActiveRecord::Base
  attr_accessible :name, :text, :banner

  paginates_per 20

  has_attached_file :banner,
                    :styles => {:main => '940x250#'},
                    :path => "/:class/:attachment/:id_partition/:style/:filename"

  has_attached_file :photo,
                    :styles => {:main => '251x200#'},
                    :path => "/:class/:attachment/:id_partition/:style/:filename"

end
