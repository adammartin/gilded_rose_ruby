require "standard_item"

describe "StandardItem" do

	describe "for standard items" do
   	before(:each) do
      @standard_item = StandardItem.new(Item.new("A standard item", 2, 4))
 		end
	 	describe "sell by date" do
	   		it "should decrease by 1 on first day" do
	   			@standard_item.age_by_a_day
	   			@standard_item.sell_in.should == 1
	   		end
	   		it "should decrease by 2 on second day" do
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.sell_in.should == 0
	   		end
	   	end
	   	describe "quality" do
	   		it "should decrease by 1 on first day" do
	   			@standard_item.age_by_a_day
	   			@standard_item.quality.should == 3
	   		end
	   		it "should decrease by 2 on second day" do
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.quality.should == 2
	   		end
	   		it "should decrease by double the standard rate after sell by date is exceeded" do
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.quality.should == 0
	   		end
	   		it "should never go negative" do
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.age_by_a_day
	   			@standard_item.quality.should == 0
	   		end
	   		it "should never exceed 50" do
   				(1..51).each{ @standard_item.age_by_a_day }
   				@standard_item.quality.should < 51
	   		end
	   	end
    end

    describe "Aged Brie" do
    	before(:each) do
   			@standard_item = StandardItem.new(Item.new("Aged Brie", 2, 0))
   		end

   		describe "increases in quality with age" do
   			it "by 1 on first day" do
   				@standard_item.age_by_a_day
   				@standard_item.quality.should == 1
   			end
   			it "by 2 on second day" do
   				@standard_item.age_by_a_day
   				@standard_item.age_by_a_day
   				@standard_item.quality.should == 2
   			end
   		end
    end

    describe "Sulfuras as a legendary item" do
    	before(:each) do
    		@original_sell_in = 100
    		@original_quality = 100
   			@standard_item = StandardItem.new(Item.new("Sulfuras, Hand of Ragnaros", @original_sell_in, @original_quality))
   		end

   		it "never needs to be sold" do
   			@standard_item.age_by_a_day
   			@standard_item.name.should == "Sulfuras, Hand of Ragnaros"
   			@standard_item.sell_in.should == @original_sell_in
   		end

   		it "never decreases in quality" do
   			@standard_item.age_by_a_day
   			@standard_item.name.should == "Sulfuras, Hand of Ragnaros"
   			@standard_item.quality.should == @original_quality
   		end
    end

    describe "Backstage passes" do
    	def sample_backstage_inventory sell_in_days, starting_quality
    		StandardItem.new(Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in_days, starting_quality))
    	end

   		it "increases in quality by 1 for sell in days greater than 10" do
	    	standard_item = sample_backstage_inventory 11, 0

	    	standard_item.age_by_a_day

	    	standard_item.quality.should == 1
   		end

   		it "increases in quality by 2 for sell in days between 5 and 10" do
   			standard_item = sample_backstage_inventory 6, 0

	    	standard_item.age_by_a_day

	    	standard_item.quality.should == 2
   		end 

   		it "increases in quality by 3 for sel ind ays between 0 and 5" do
   			standard_item = sample_backstage_inventory 1, 0

	    	standard_item.age_by_a_day

	    	standard_item.quality.should == 3
   		end

   		it "drops to 0 when sell_in day is exceed" do
   			standard_item = sample_backstage_inventory 0, 100

	    	standard_item.age_by_a_day

	    	standard_item.quality.should == 0
   		end
   	end
end