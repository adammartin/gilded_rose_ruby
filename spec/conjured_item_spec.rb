require "conjured_item"

describe "ConjuredItem" do
	before(:each) do
		@conjured_item = ConjuredItem.new(Item.new("Conjured Mana Cake", 5, 10))
	end
	describe "like a standard item" do
   		it "should decrease by 1 on first day" do
   			@conjured_item.age_by_a_day
   			@conjured_item.sell_in.should == 4
   		end
   		it "should decrease by 2 on second day" do
   			@conjured_item.age_by_a_day
   			@conjured_item.age_by_a_day
   			@conjured_item.sell_in.should == 3
   		end
	end
	describe "quality decreases at twice the rate" do
		it "reducing quality by 2 on first day" do
			@conjured_item.age_by_a_day
			@conjured_item.quality.should == 8
		end
		it "reducing quality by 4 on second day" do
			@conjured_item.age_by_a_day
			@conjured_item.age_by_a_day
			@conjured_item.quality.should == 6
		end
   		it "should decrease by double the standard rate after sell by date is exceeded" do
   			@conjured_item = ConjuredItem.new(Item.new("Conjured Mana Cake", 0, 10))
   			@conjured_item.age_by_a_day
   			@conjured_item.quality.should == 6
   		end
		it "still never goes negative" do
   			@conjured_item = ConjuredItem.new(Item.new("Conjured Mana Cake", 0, 0))
			@conjured_item.age_by_a_day
			@conjured_item.quality.should == 0
		end
	end
end