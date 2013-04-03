class SpecialsController < ApplicationController
  def index
    @specials = Special.order("id desc").all
  end
end
