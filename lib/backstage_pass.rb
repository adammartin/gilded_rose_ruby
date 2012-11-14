require "base_item"

class BackstagePass < BaseItem
  def age_by_a_day
  	update_quality
	@my_item.sell_in -= 1
  end

  private

  def update_quality
  	item.quality = item.quality + decay_rate
  end

  def decay_rate
  	if @my_item.sell_in > 10
  		1
  	elsif @my_item.sell_in > 5
  		2
  	elsif @my_item.sell_in > 0
  		3
  	else
  		0 - @my_item.quality
  	end
  end
end