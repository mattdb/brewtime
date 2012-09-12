require 'spec_helper'

describe Step do
  it { should validate_presence_of :name }
  it { should validate_presence_of :min_length }
  it { should validate_presence_of :max_length }
  
  describe "#complete?" do
    it "is truthy when step has completion date" do
      step = build(:step, actual_length: 10)
      step.complete?.should be_true
    end
    it "is false when step has no completion date" do
      step = build(:step, actual_length: nil)
      step.complete?.should be_false
    end
  end

  describe "#complete!" do
    let(:step) { build(:step, start: 11.days.ago) }
    
    it "stores number of days since start in actual_length" do
      step.complete!
      step.actual_length.should eq(11)
    end
    it "saves the record" do
      step.complete!
      step.changed?.should be_false
    end
    it "returns number of days" do
      step.complete!.should eq(11)
    end
  end
  
  describe "#soonest_end" do
    
    context "with no start date" do
      let(:step) { build(:step, start: nil) }
      
      it "returns nil" do
        step.soonest_end.should be_nil
      end
    end
    
    context "with start date" do
      let(:step) { build(:step, start: 9.days.ago, min_length:4) }
      
      it "returns correct soonest end date" do
        step.soonest_end.should eql(step.start + 4.days)
      end
    end
    
    context "with start and end date" do
      let(:step) { build(:step, start: 9.days.ago, actual_length: 7, min_length: 3) }
      
      it "returns actual end date" do
        step.soonest_end.should eq(step.start + 7.days)
      end
    end
  end
  
  describe "#latest_end" do
    
    context "with no start date" do
      let(:step) { build(:step, start: nil) }
      
      it "returns nil" do
        step.latest_end.should be_nil
      end
    end
    
    context "with start date" do
      let(:step) { build(:step, start: 9.days.ago, max_length:10) }
      
      it "returns correct latest end date" do
        step.latest_end.should eql(step.start + 10.days)
      end
    end
    
    context "with start and end date" do
      let(:step) { build(:step, start: 9.days.ago, actual_length: 7, max_length: 3) }
      
      it "returns actual end date" do
        step.latest_end.should eq(step.start + 7.days)
      end
    end
  end
  
  describe "#actual_end" do
    context "with no start date" do
      let(:step) { build(:step, start: nil) }
      
      it "returns nil" do
        step.actual_end.should be_nil
      end
    end
    
    context "with start date but no actual length" do
      let(:step) { build(:step, start: 12.days.ago, actual_length:nil) }
      
      it "returns nil" do
        step.actual_end.should be_nil
      end
    end
    
    context "with start date and actual length specified" do
      let(:step) { build(:step, start: 12.days.ago, actual_length:8) }
      
      it "returns expected date" do
        step.actual_end.should eq(step.start + 8.days)
      end
    end
  end
end
