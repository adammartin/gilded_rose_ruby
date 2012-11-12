require 'item'
require 'standard_item'

class Inventory
  attr_accessor :items
  def initialize new_items
    @items = new_items
  end

  def age_by_a_day
    for i in 0..(@items.size-1)
      @items[i].age_by_a_day
    end
  end

end