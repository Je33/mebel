class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_basket

  def get_basket
    if user_signed_in?
      if current_user.last_basket.to_i > 0
        bsk = Order.find(current_user.last_basket)
        if bsk.status.to_i == 0
          @order = bsk
        end
      end
    else
      if cookies[:last_basket].to_i > 0
        bsk = Order.find(cookies[:last_basket]).first
        if bsk
          @order = bsk
        end
      else
        if session[:session_id]
          bsk = Order.find_by_session(session[:session_id]).first
          if bsk
            @order = bsk
          end
        end
      end
    end
    @order ||= Order.new({:session => session[:session_id], :status => 0})
  end

end
