module ApplicationHelper
  def readable_price(price)
    ("<span class='price'>" + number_with_precision(price, :precision => 2, :delimiter => ',') + "</span>").html_safe
  end
end
