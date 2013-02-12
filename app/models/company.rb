class Company < ActiveRecord::Base
  attr_accessible :name, :text

  paginates_per 20

  has_many :categories

end
