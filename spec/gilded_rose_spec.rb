require "gilded_rose"

describe GildedRose do
  before(:each) do
    @back_stage_pass_name = "Backstage passes to a TAFKAL80ETC concert"
    @aged_brie_name = "Aged Brie"
    @vest_name = "+5 Dexterity Vest"
    @sulfuras_name = "Sulfuras, Hand of Ragnaros"
  end

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
      	subject.age_by_a_day
      	subject.items.each{|item| original_sell_dates[item.name] > 0 ? 
      									item.sell_in.should < original_sell_dates[item.name] :
      									item.sell_in.should == 0 }
      end
      it "Should decrease in quality at end of each day unless it is 'Aged Brie'" do
      	original_quality = {}
      	subject.items.each{|item| original_quality.store(item.name, item.quality) }
      	subject.age_by_a_day
      	subject.items.each{|item| if item.name != @aged_brie_name
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
            (0..8).each{ subject.age_by_a_day }
            @dextrity_vest = item_with_name(@vest_name)
            @dextrity_vest.sell_in == 0
            @quality_at_zero = @dextrity_vest.quality
            @amount_to_decrease_by_below_zero = 2
          end
          it "should decrease the value by 2 for one night" do
            subject.age_by_a_day
            current_quality = item_with_name(@vest_name).quality
            current_quality == @quality_at_zero - @amount_to_decrease_by_below_zero
          end
          it "should decrease the value by 4 for two night" do
            subject.age_by_a_day
            subject.age_by_a_day
            current_quality = item_with_name(@vest_name).quality
            current_quality == @quality_at_zero - (@amount_to_decrease_by_below_zero * 2)
          end
        end

        it " can never let quality become negative" do
          (0..1000).each{ subject.age_by_a_day }
          subject.items.each{|item| item.quality >= 0 }
        end

        describe "Aged Brie increases in value with age" do
          before(:each) do
            @aged_brie = item_with_name(@aged_brie_name)
            @original_quality = @aged_brie.quality
          end

          it "increases in quality by 1 on first day" do
            subject.age_by_a_day
            current_quality = item_with_name(@aged_brie_name).quality
            current_quality.should == @original_quality + 1
          end

          it "increases in quality to 2 on the second day" do
            subject.age_by_a_day
            subject.age_by_a_day
            current_quality = item_with_name(@aged_brie_name).quality
            current_quality.should == @original_quality + 2
          end
        end

        describe "No item can have it's quality increase to over 50" do
          it "should start with no items that have an intiial quality over 50 if not Sulfuras" do
            items = subject.items
            items.delete_if{|item| item.name == @sulfuras_name}
            items.each{|item| item.quality.should <= 50 }
          end

          it "cannot increase greater then 50 over it's life if not Sulfuras" do
            (0..1000).each{ subject.age_by_a_day }
            items = subject.items
            items.delete_if{|item| item.name == @sulfuras_name}
            items.each{|item| item.quality.should <= 50 }
          end
        end

        describe "Sulfuras is legendary and" do
          it "never decreases in quality" do
            original_sulfuras_quality = item_with_name(@sulfuras_name).quality
            (0..1000).each{ subject.age_by_a_day }
            original_sulfuras_quality.should == item_with_name(@sulfuras_name).quality
          end
          it "never needs to be sold" do
            original_sulfuras = item_with_name(@sulfuras_name)
            (0..1000).each{ subject.age_by_a_day }
            original_sulfuras.sell_in.should == item_with_name(@sulfuras_name).sell_in
          end
        end

        describe "Backstage passes" do

          def days_till day, for_item
            (for_item.sell_in - day)
          end

          def quality_at days_till_sell_in, for_item
            (1 .. days_till_sell_in).each{ subject.age_by_a_day }
            for_item.quality
          end

          it "increases in quality while not 0" do
            original_backstage_pass_quality = item_with_name(@back_stage_pass_name).quality

            subject.age_by_a_day

            current_back_stage_pass = item_with_name(@back_stage_pass_name)
            current_back_stage_pass.quality.should == original_backstage_pass_quality + 1
          end
          it "increases in quality by 2 from a sell_in between 5 and 10" do
            back_stage_pass = item_with_name(@back_stage_pass_name)
            quality_at_ten = quality_at(days_till(10, back_stage_pass), back_stage_pass)

            subject.age_by_a_day

            back_stage_pass.quality.should == quality_at_ten + 2
          end

          it "increases in quality by 2 from a sell_in between 0 and 5" do
            back_stage_pass = item_with_name(@back_stage_pass_name)
            quality_at_five = quality_at(days_till(5, back_stage_pass), back_stage_pass)

            subject.age_by_a_day

            back_stage_pass.quality.should == quality_at_five + 3
          end

          it "drops to 0 when sell in day is 0" do
            back_stage_pass = item_with_name(@back_stage_pass_name)
            quality_at_five = quality_at(days_till(0, back_stage_pass), back_stage_pass)

            subject.age_by_a_day

            back_stage_pass.quality.should == 0
          end
        end
      end
    end
  end
end