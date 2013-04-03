class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_basket, :get_settings

  def get_basket
    if user_signed_in?
      if current_user.last_basket.to_i > 0
        bsk = Order.where(:id => current_user.last_basket, :status => 0).first
        if bsk and bsk.status.to_i == 0
          @order = bsk
        end
      end
    end
    if cookies[:last_basket].to_i > 0
      bsk = Order.where(:id => cookies[:last_basket], :status => 0).first
      if bsk
        @order = bsk
      end
    else
      if session[:session_id]
        bsk = Order.where(:session => session[:session_id], :status => 0).first
        if bsk
          @order = bsk
        end
      end
    end
    @order ||= Order.new
  end

  def get_settings
    settings = Setting.all
    @settings = {}
    if settings
      settings.each do |s|
        @settings[s.name] = s.value
      end
    end
  end

end
