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
  	update_quality
  	@my_item.sell_in -= 1
  end

  private

  def update_quality
  	post_decay = @my_item.quality - decay_rate
  	@my_item.quality = (post_decay >= 0) ? post_decay : 0
  end

  def decay_rate
  	@my_item.sell_in > 0 ? 2 : 4
  end
end