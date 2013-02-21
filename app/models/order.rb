class Order < ActiveRecord::Base
  attr_accessible :city, :floor, :house, :name, :phone, :room, :status, :street, :text, :session

  has_many :baskets, :dependent => :destroy

  paginates_per 20

end
