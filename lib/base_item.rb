require 'item'

class BaseItem
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
end