require "backstage_pass"

describe "BackstagePass" do
	before(:each) do
		@backstage_pass = BackstagePass.new(Item.new("Backstage Pass", 5, 0))
	end

   def sample_backstage_inventory sell_in_days, starting_quality
      BackstagePass.new(Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in_days, starting_quality))
   end

	describe "like a standard item sell in" do
		it "should decrease by 1 on first day" do
			@backstage_pass.age_by_a_day
			@backstage_pass.sell_in.should == 4
		end
		it "should decrease by 2 on second day sell in" do
			@backstage_pass.age_by_a_day
			@backstage_pass.age_by_a_day
			@backstage_pass.sell_in.should == 3
		end
		it "should never have a sell_in day below 0" do
			(1..10).each{ @backstage_pass.age_by_a_day }
			@backstage_pass.sell_in.should == 0
		end
	   it "should never go negative quality" do
         (1..51).each{ @backstage_pass.age_by_a_day }
			@backstage_pass.quality.should >= 0
		end
		it "should never exceed 50 quality" do
			(1..51).each{ @backstage_pass.age_by_a_day }
			@backstage_pass.quality.should < 51
		end
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