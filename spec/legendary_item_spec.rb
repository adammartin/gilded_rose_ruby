require "legendary_item"

describe "LegendaryItem" do
	before(:each) do
		@conjured_item = LegendaryItem.new(Item.new("Legendary Item", 100, 100))
	end
	it "never needs to be sold" do
		@conjured_item.age_by_a_day
		@conjured_item.sell_in.should == 100
	end

	it "never decreases in quality" do
		@conjured_item.age_by_a_day
		@conjured_item.quality.should == 100
	end
end