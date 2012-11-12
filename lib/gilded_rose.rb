require 'item'
require 'standard_item'
require 'inventory'

class GildedRose

  attr_accessor :items
  @inventory

  def initialize
    @items = []
    @items << StandardItem.new(Item.new("+5 Dexterity Vest", 10, 20))
    @items << StandardItem.new(Item.new("Aged Brie", 2, 0))
    @items << StandardItem.new(Item.new("Elixir of the Mongoose", 5, 7))
    @items << StandardItem.new(Item.new("Sulfuras, Hand of Ragnaros", 0, 80))
    @items << StandardItem.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20))
    @items << StandardItem.new(Item.new("Conjured Mana Cake", 3, 6))
    @inventory = Inventory.new(@items)
  end

  def age_by_a_day
    @inventory.age_by_a_day
  end

end