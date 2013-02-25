class Kind < ActiveRecord::Base
  attr_accessible :texture_id, :name, :photo

  belongs_to :texture

  has_attached_file :photo, :styles => {:s => '50x50#', :m => '300x300'}
end
