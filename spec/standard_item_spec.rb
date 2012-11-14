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
end