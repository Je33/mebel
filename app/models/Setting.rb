class Setting < ActiveRecord::Base
  attr_accessible :name, :value
  paginates_per 20

end