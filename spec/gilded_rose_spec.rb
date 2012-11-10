require "gilded_rose"

describe GildedRose do
  it "Should have items that have a sell by date" do
    subject.items.each{| item | item.instance_variable_defined?(:@sell_in).should == true}
  end
  it "Should have items that have a quality" do
    subject.items.each{| item | item.instance_variable_defined?(:@quality).should == true}  	
  end
  it "Should decrease in sell by date at end of each day till 0" do
  	original_sell_dates = {}
  	subject.items.each{|item| original_sell_dates.store(item.name, item.sell_in) }
  	subject.update_quality
  	subject.items.each{|item| original_sell_dates[item.name] > 0 ? 
  									item.sell_in.should < original_sell_dates[item.name] :
  									item.sell_in.should == 0 }
  end
  it "Should decrease in quality at end of each day unless it is 'Aged Brie'" do
  	original_quality = {}
  	subject.items.each{|item| original_quality.store(item.name, item.quality) }
  	subject.update_quality
  	subject.items.each{|item| if item.name != "Aged Brie"
  								item.sell_in.should < original_quality[item.name]
  							  end }
  end
end