class AdminController < ApplicationController

  layout "admin"
  before_filter :authenticate_user!

  def index
    @breads = [['Admin', '/admin']]

  end

end
