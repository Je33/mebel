class Setting < ActiveRecord::Base
  attr_accessible :name, :value
  paginates_per 20

  def get(name)
    if Setting.where(:name => name).exists?
      Setting.find_by_name(name).name
    else
      ""
    end
  end

end