require 'item'

class Inventory
  attr_accessor :items
  def initialize new_items
    @items = new_items
  end

  def age_by_a_day
    increase_sell_in
    update_quality
  end

  private

  @sulfuras = "Sulfuras, Hand of Ragnaros"

  def increase_sell_in
    items.each{|item| unless item.name == @sulfuras then item.sell_in -= 1 end}
  end

  def update_quality
    for i in 0..(@items.size-1)
      if (@items[i].name != "Aged Brie" && @items[i].name != "Backstage passes to a TAFKAL80ETC concert")
        if (@items[i].quality > 0)
          if (@items[i].name != @sulfuras)
            @items[i].quality = @items[i].quality - 1
          end
        end
      else
        if (@items[i].quality < 50)
          @items[i].quality = @items[i].quality + 1
          if (@items[i].name == "Backstage passes to a TAFKAL80ETC concert")
            if (@items[i].sell_in < 11)
              if (@items[i].quality < 50)
                @items[i].quality = @items[i].quality + 1
              end
            end
            if (@items[i].sell_in < 6)
              if (@items[i].quality < 50)
                @items[i].quality = @items[i].quality + 1
              end
            end
          end
        end
      end
      if (@items[i].sell_in < 0)
        if (@items[i].name != "Aged Brie")
          if (@items[i].name != "Backstage passes to a TAFKAL80ETC concert")
            if (@items[i].quality > 0)
              if (@items[i].name != @sulfuras)
                @items[i].quality = @items[i].quality - 1
              end
            end
          else
            @items[i].quality = @items[i].quality - @items[i].quality
          end
        else
          if (@items[i].quality < 50)
            @items[i].quality = @items[i].quality + 1
          end
        end
      end
    end
  end
end