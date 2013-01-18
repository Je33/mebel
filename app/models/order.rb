class Order < ActiveRecord::Base
  attr_accessible :city, :floor, :house, :name, :phone, :room, :status, :street, :text
end
