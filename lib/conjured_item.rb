require "base_item"

class ConjuredItem < BaseItem
  def age_by_a_day
  	update_quality
  	if @my_item.sell_in > 0 then
      @my_item.sell_in -= 1
    end
  end

  private

  def update_quality
  	post_decay = item.quality - decay_rate
  	item.quality = (post_decay >= 0) ? post_decay : 0
  end

  def decay_rate
  	item.sell_in > 0 ? 2 : 4
  end
end