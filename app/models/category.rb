class Category < ActiveRecord::Base
  attr_accessible :cnt, :name, :text, :photo,
                  :page_title, :page_description, :page_keywords

  has_many :products

  has_attached_file :photo,
                    :styles => {:s => '50x50', :m => '188x150'},
                    :path => "/:class/:attachment/:id_partition/:style/:filename"

end
