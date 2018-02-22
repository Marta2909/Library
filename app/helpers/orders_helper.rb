module OrdersHelper
  def count_debt(order)
    if (((order.deadline - Date.today.to_datetime).to_i/1.day < 0) && ((order.deadline - Date.today.to_datetime).to_i/1.day >= -5) && (order.is_returned == false))
      order.debt = 10.0
    elsif ((order.deadline - Date.today.to_datetime).to_i/1.day < -5) && (order.is_returned == false)
      order.debt = 50.0
    else
      order.debt = 0.0
    end
  end
end
