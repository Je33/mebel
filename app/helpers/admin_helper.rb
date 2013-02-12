module AdminHelper

  def get_order_class(status)
    st = status.to_i
    case st
      when 0
        "info"
      when 10
        "warning"
      when 20
        "error"
      when 30
        "success"
    end
  end

  def get_order_address(order)
    out = []
    if !order.city.blank?
      out << order.city
    end
    if !order.street.blank?
      out << order.street
    end
    if !order.house.blank?
      out << order.house
    end
    if !order.floor.blank?
      out << order.floor
    end
    if !order.room.blank?
      out << order.room
    end
    out.join(", ")
  end

end
