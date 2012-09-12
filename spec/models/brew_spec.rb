require 'spec_helper'

describe Brew do
  it { should validate_presence_of :name }
  it { should validate_presence_of :brewed }
  
  describe "#current_step" do
    it "returns 1st step when none complete" do
      brew = create(:brew_with_steps)
      brew.current_step.should be(brew.steps[0])
    end
    it "returns 2nd step when 1st step complete" do
      brew = create(:brew_with_steps)
      brew.steps[0].actual_length = 10
      brew.current_step.should be(brew.steps[1])
    end
  end
end
