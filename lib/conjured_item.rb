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
  	quality_decay_amount = @my_item.sell_in > 0 ? 2 : 4
  	@my_item.sell_in -= 1
  	((@my_item.quality - quality_decay_amount) >= 0) ? 
  				@my_item.quality -= quality_decay_amount : 
  				@my_item.quality == 0
  end
end