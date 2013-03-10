class Company < ActiveRecord::Base
  attr_accessible :name, :text, :email, :production, :delivery, :elevation, :installation

  paginates_per 20

  has_many :products, :dependent => :destroy

end
