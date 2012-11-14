require "base_item"

class AgedBrie < BaseItem
  def age_by_a_day
  	update_quality
	@my_item.sell_in -= 1
  end

  private

  def update_quality
  	item.quality = item.quality + decay_rate
  end

  def decay_rate
  	item.quality < 50 ? 1 : 0
  end
end