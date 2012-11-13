require "item"

class ConjuredItem
  @my_item

  def initialize an_item
  	@my_item = an_item
  end

  def quality
  	 @my_item.quality
  end

  def name
  	 @my_item.name
  end

  def sell_in
  	@my_item.sell_in
  end

  def item
  	@my_item
  end

  def age_by_a_day
  	@my_item.sell_in -= 1
  	((@my_item.quality - 2) >= 0) ? @my_item.quality -= 2 : @my_item.quality == 0
  end
end