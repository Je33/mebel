class Special < ActiveRecord::Base
  attr_accessible :name, :text

  has_attached_file :banner, :styles => {:main => '940x250#'}

end
