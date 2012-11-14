require 'item'
require 'aged_brie'
require 'conjured_item'
require 'standard_item'
require 'legendary_item'
require 'backstage_pass'

class GildedRose

  @items = []
  @inventory

  def items
    @items
  end

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)

    @inventory = @items.collect{|an_item| 
                                    case an_item.name
                                    when "Conjured Mana Cake" 
                                      ConjuredItem.new(an_item)
                                    when "Sulfuras, Hand of Ragnaros"
                                      LegendaryItem.new(an_item)
                                    when "Aged Brie"
                                      AgedBrie.new(an_item)
                                    when "Backstage passes to a TAFKAL80ETC concert"
                                      BackstagePass.new(an_item)
                                    else
                                      StandardItem.new(an_item)
                                    end
                                }
  end

  def age_by_a_day
    @inventory.each {|an_item| an_item.age_by_a_day}
  end

end