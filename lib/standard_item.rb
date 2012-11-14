require "base_item"

class StandardItem < BaseItem
  def age_by_a_day
    @my_item.quality = (@my_item.quality > 0) ? @my_item.quality - decay_rate : 0
    @my_item.sell_in -= 1;
  end

  private

  def decay_rate
    @my_item.sell_in > 0 ? 1 : 2
  end
end
