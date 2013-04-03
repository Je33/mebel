class AddAttachmentToSpecials < ActiveRecord::Migration
  def change
    add_attachment :specials, :photo
  end
end
