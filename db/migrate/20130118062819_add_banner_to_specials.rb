class AddBannerToSpecials < ActiveRecord::Migration
  def self.up
    add_attachment :specials, :banner
  end

  def self.down
    remove_attachment :specials, :banner
  end
end
