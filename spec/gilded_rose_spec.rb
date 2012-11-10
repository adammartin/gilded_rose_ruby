require "gilded_rose"

describe GildedRose do
  it "Should have items that have a sell by date" do
    subject.items.each{| item | item.instance_variable_defined?(:@sell_in).should == true}
  end
  it "Should have items that have a quality" do
    subject.items.each{| item | item.instance_variable_defined?(:@quality).should == true}  	
  end
end