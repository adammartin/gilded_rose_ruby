require "base_item"

class StandardItem < BaseItem
  def age_by_a_day
      if (@my_item.name != "Aged Brie" && @my_item.name != "Backstage passes to a TAFKAL80ETC concert")
        if (@my_item.quality > 0)
          if (@my_item.name != "Sulfuras, Hand of Ragnaros")
            @my_item.quality = @my_item.quality - 1
          end
        end
      else
        if (@my_item.quality < 50)
          @my_item.quality = @my_item.quality + 1
          if (@my_item.name == "Backstage passes to a TAFKAL80ETC concert")
            if (@my_item.sell_in < 11)
              if (@my_item.quality < 50)
                @my_item.quality = @my_item.quality + 1
              end
            end
            if (@my_item.sell_in < 6)
              if (@my_item.quality < 50)
                @my_item.quality = @my_item.quality + 1
              end
            end
          end
        end
      end
      if (@my_item.name != "Sulfuras, Hand of Ragnaros")
        @my_item.sell_in = @my_item.sell_in - 1;
      end
      if (@my_item.sell_in < 0)
        if (@my_item.name != "Aged Brie")
          if (@my_item.name != "Backstage passes to a TAFKAL80ETC concert")
            if (@my_item.quality > 0)
              if (@my_item.name != "Sulfuras, Hand of Ragnaros")
                @my_item.quality = @my_item.quality - 1
              end
            end
          else
            @my_item.quality = @my_item.quality - @my_item.quality
          end
        else
          if (@my_item.quality < 50)
            @my_item.quality = @my_item.quality + 1
          end
        end
      end
    end

end
