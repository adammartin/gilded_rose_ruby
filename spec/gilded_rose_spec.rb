require "gilded_rose"

describe GildedRose do
  describe "Original Characterization Tests:\n" do
    describe "Introduction description of the system:\n" do
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

    describe "Complex description of the system behavior:\n" do

      def item_with_name item_name
        subject.items.select{|item| item.name == item_name}[0]
      end

      describe "Once the sell by date passes" do
        describe "for normal objects quality degrades at double the standard rate" do
          before(:each) do
            (0..8).each{ subject.update_quality }
            @dextrity_vest = item_with_name("+5 Dexterity Vest")
            @dextrity_vest.sell_in == 0
            @quality_at_zero = @dextrity_vest.quality
            @amount_to_decrease_by_below_zero = 2
          end
          it "should decrease the value by 2 for one night" do
            subject.update_quality
            current_quality = item_with_name("+5 Dexterity Vest").quality
            current_quality == @quality_at_zero - @amount_to_decrease_by_below_zero
          end
          it "should decrease the value by 4 for two night" do
            subject.update_quality
            subject.update_quality
            current_quality = item_with_name("+5 Dexterity Vest").quality
            current_quality == @quality_at_zero - (@amount_to_decrease_by_below_zero * 2)
          end
        end

        it " can never let quality become negative" do
          (0..1000).each{ subject.update_quality }
          subject.items.each{|item| item.quality >= 0 }
        end

        describe "Aged Brie increases in value with age" do
          before(:each) do
            @aged_brie = item_with_name("Aged Brie")
            @original_quality = @aged_brie.quality
          end

          it "increases in quality by 1 on first day" do
            subject.update_quality
            current_quality = item_with_name("Aged Brie").quality
            current_quality.should == @original_quality + 1
          end

          it "increases in quality to 2 on the second day" do
            subject.update_quality
            subject.update_quality
            current_quality = item_with_name("Aged Brie").quality
            current_quality.should == @original_quality + 2
          end
        end

        describe "No item can have it's quality increase to over 50" do
          it "should start with no items that have an intiial quality over 50 if not Sulfuras" do
            items = subject.items
            items.delete_if{|item| item.name == "Sulfuras, Hand of Ragnaros"}
            items.each{|item| item.quality.should <= 50 }
          end

          it "cannot increase greater then 50 over it's life if not Sulfuras" do
            (0..1000).each{ subject.update_quality }
            items = subject.items
            items.delete_if{|item| item.name == "Sulfuras, Hand of Ragnaros"}
            items.each{|item| item.quality.should <= 50 }
          end
        end

        describe "Sulfuras is legendary and" do
          it "never decreases in quality" do
            original_sulfuras_quality = item_with_name("Sulfuras, Hand of Ragnaros").quality
            (0..1000).each{ subject.update_quality }
            original_sulfuras_quality.should == item_with_name("Sulfuras, Hand of Ragnaros").quality
          end
          it "never needs to be sold" do
            original_sulfuras = item_with_name("Sulfuras, Hand of Ragnaros")
            (0..1000).each{ subject.update_quality }
            original_sulfuras.sell_in.should == item_with_name("Sulfuras, Hand of Ragnaros").sell_in
          end
        end

        describe "Backstage passes" do

          def days_till day, for_item
            (for_item.sell_in - day)
          end

          def quality_at days_till_sell_in, for_item
            (1 .. days_till_sell_in).each{ subject.update_quality }
            for_item.quality
          end

          before(:each) do
            @back_stage_pass_name = "Backstage passes to a TAFKAL80ETC concert"
          end

          it "increases in quality while not 0" do
            original_backstage_pass_quality = item_with_name(@back_stage_pass_name).quality

            subject.update_quality

            current_back_stage_pass = item_with_name(@back_stage_pass_name)
            current_back_stage_pass.quality.should == original_backstage_pass_quality + 1
          end
          it "increases in quality by 2 from a sell_in between 5 and 10" do
            back_stage_pass = item_with_name(@back_stage_pass_name)
            quality_at_ten = quality_at(days_till(10, back_stage_pass), back_stage_pass)

            subject.update_quality

            back_stage_pass.quality.should == quality_at_ten + 2
          end

          it "increases in quality by 2 from a sell_in between 5 and 10" do
            back_stage_pass = item_with_name(@back_stage_pass_name)
            quality_at_five = quality_at(days_till(5, back_stage_pass), back_stage_pass)

            subject.update_quality

            back_stage_pass.quality.should == quality_at_five + 3
          end

          it "drops to 0 when sell in day is 0" do
            back_stage_pass = item_with_name(@back_stage_pass_name)
            quality_at_five = quality_at(days_till(0, back_stage_pass), back_stage_pass)

            subject.update_quality

            back_stage_pass.quality.should == 0
          end
        end
      end
    end
  end
end