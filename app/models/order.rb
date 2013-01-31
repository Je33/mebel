class Order < ActiveRecord::Base
  attr_accessible :city, :floor, :house, :name, :phone, :room, :status, :street, :text

  has_many :basket

  paginates_per 20

end
