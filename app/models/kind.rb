class Kind < ActiveRecord::Base
  attr_accessible :texture_id, :name, :photo

  paginates_per 20

  belongs_to :texture

  has_attached_file :photo,
                    :styles => {:s => '50x50#', :m => '300x300'},
                    :path => "/:class/:attachment/:id_partition/:style/:filename"
end
