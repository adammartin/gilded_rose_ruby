require "inventory"

describe "Inventory" do

	describe "for standard items" do
   		before(:each) do
   			@items = []
	    	@items << Item.new("A standard item", 2, 4)
	    	@inventory = Inventory.new(@items)
   		end
	 	describe "sell by date" do
	   		it "should decrease by 1 on first day" do
	   			@inventory.update_quality
	   			@items[0].sell_in.should == 1
	   		end
	   		it "should decrease by 2 on second day" do
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@items[0].sell_in.should == 0
	   		end
	   	end
	   	describe "quality" do
	   		it "should decrease by 1 on first day" do
	   			@inventory.update_quality
	   			@items[0].quality.should == 3
	   		end
	   		it "should decrease by 2 on second day" do
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@items[0].quality.should == 2
	   		end
	   		it "should decrease by double the standard rate after sell by date is exceeded" do
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@items[0].quality.should == 0
	   		end
	   		it "should never go negative" do
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@inventory.update_quality
	   			@items[0].quality.should == 0
	   		end
	   	end
    end

    describe "Aged Brie" do
    	before(:each) do
   			@items = []
	    	@items << Item.new("Aged Brie", 2, 0)
	    	@inventory = Inventory.new(@items)
   		end

   		describe "increases in quality with age" do
   			it "by 1 on first day" do
   				@inventory.update_quality
   				@items[0].quality.should == 1
   			end
   			it "by 2 on second day" do
   				@inventory.update_quality
   				@inventory.update_quality
   				@items[0].quality.should == 2
   			end
   		end
    end
end