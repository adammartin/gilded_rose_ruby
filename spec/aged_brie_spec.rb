require "aged_brie"

describe "Aged Brie" do
	before(:each) do
		@aged_brie = AgedBrie.new(Item.new("Aged Brie", 5, 0))
	end
	describe "like a standard item sell in" do
   		it "should decrease by 1 on first day" do
   			@aged_brie.age_by_a_day
   			@aged_brie.sell_in.should == 4
   		end
   		it "should decrease by 2 on second day sell in" do
   			@aged_brie.age_by_a_day
   			@aged_brie.age_by_a_day
   			@aged_brie.sell_in.should == 3
   		end
   		it "should never have a sell_in day below 0" do
			(1..10).each{ @aged_brie.age_by_a_day }
			@aged_brie.sell_in.should == 0
   		end
		it "should never go negative quality" do
   			@aged_brie.age_by_a_day
   			@aged_brie.age_by_a_day
   			@aged_brie.age_by_a_day
   			@aged_brie.age_by_a_day
   			@aged_brie.quality.should >= 0
   		end
   		it "should never exceed 50 quality" do
			(1..51).each{ @aged_brie.age_by_a_day }
			@aged_brie.quality.should < 51
   		end
	end
	describe "increases in quality with age" do
		it "by 1 on first day" do
			@aged_brie.age_by_a_day
			@aged_brie.quality.should == 1
		end
		it "by 2 on second day" do
			@aged_brie.age_by_a_day
			@aged_brie.age_by_a_day
			@aged_brie.quality.should == 2
		end
	end
end