require "inventory"

describe "Inventory" do

	describe "for standard items" do
 		before(:each) do
 			@items = []
    	@items << StandardItem.new(Item.new("A standard item", 2, 4))
    	@inventory = Inventory.new(@items)
 		end
	 	describe "sell by date" do
	   		it "should decrease by 1 on first day" do
	   			@inventory.age_by_a_day
	   			@items[0].sell_in.should == 1
	   		end
	   		it "should decrease by 2 on second day" do
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@items[0].sell_in.should == 0
	   		end
	   	end
	   	describe "quality" do
	   		it "should decrease by 1 on first day" do
	   			@inventory.age_by_a_day
	   			@items[0].quality.should == 3
	   		end
	   		it "should decrease by 2 on second day" do
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@items[0].quality.should == 2
	   		end
	   		it "should decrease by double the standard rate after sell by date is exceeded" do
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@items[0].quality.should == 0
	   		end
	   		it "should never go negative" do
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@inventory.age_by_a_day
	   			@items[0].quality.should == 0
	   		end
	   		it "should never exceed 50" do
   				(1..51).each{ @inventory.age_by_a_day }
   				@items[0].quality.should < 51
	   		end
	   	end
    end

    describe "Aged Brie" do
    	before(:each) do
   			@items = []
	    	@items << StandardItem.new(Item.new("Aged Brie", 2, 0))
	    	@inventory = Inventory.new(@items)
   		end

   		describe "increases in quality with age" do
   			it "by 1 on first day" do
   				@inventory.age_by_a_day
   				@items[0].quality.should == 1
   			end
   			it "by 2 on second day" do
   				@inventory.age_by_a_day
   				@inventory.age_by_a_day
   				@items[0].quality.should == 2
   			end
   		end
    end

    describe "Sulfuras as a legendary item" do
    	before(:each) do
    		@original_sell_in = 100
    		@original_quality = 100
   			@items = []
	    	@items << StandardItem.new(Item.new("Sulfuras, Hand of Ragnaros", @original_sell_in, @original_quality))
	    	@inventory = Inventory.new(@items)
   		end

   		it "never needs to be sold" do
   			@inventory.age_by_a_day
   			@items[0].name.should == "Sulfuras, Hand of Ragnaros"
   			@items[0].sell_in.should == @original_sell_in
   		end

   		it "never decreases in quality" do
   			@inventory.age_by_a_day
   			@items[0].name.should == "Sulfuras, Hand of Ragnaros"
   			@items[0].quality.should == @original_quality
   		end
    end

    describe "Backstage passes" do
    	before(:each) do
    		@items = []
    	end
    	def sample_backstage_inventory sell_in_days, starting_quality
    		@items = []
	    	@items << StandardItem.new(Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in_days, starting_quality))
	    	Inventory.new(@items)
    	end

   		it "increases in quality by 1 for sell in days greater than 10" do
	    	inventory = sample_backstage_inventory 11, 0

	    	inventory.age_by_a_day

	    	@items[0].quality.should == 1
   		end

   		it "increases in quality by 2 for sell in days between 5 and 10" do
   			inventory = sample_backstage_inventory 6, 0

	    	inventory.age_by_a_day

	    	@items[0].quality.should == 2
   		end 

   		it "increases in quality by 3 for sel ind ays between 0 and 5" do
   			inventory = sample_backstage_inventory 1, 0

	    	inventory.age_by_a_day

	    	@items[0].quality.should == 3
   		end

   		it "drops to 0 when sell_in day is exceed" do
   			inventory = sample_backstage_inventory 0, 100

	    	inventory.age_by_a_day

	    	@items[0].quality.should == 0
   		end
   	end
end