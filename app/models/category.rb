class Category < ActiveRecord::Base
  attr_accessible :cnt, :name, :text

  belongs_to :company

  has_many :products

end
