require 'spec_helper'

describe Navigation::ProgramNavigator do
  describe "initialization" do
    it "uses the PhaseStrategy for Phase objects" do
      n = Navigation::ProgramNavigator.new(FactoryGirl.build(:phase),
                                           User.new)
      n.strategy.should be_instance_of(Navigation::PhaseStrategy)
    end
    it "uses the SectionStrategy for Section objects" do
      n = Navigation::ProgramNavigator.new(FactoryGirl.build(:section),
                                           User.new)
      n.strategy.should be_instance_of(Navigation::SectionStrategy)
    end
    it "uses the SectionStepStrategy for SectionStep objects" do
      n = Navigation::ProgramNavigator.new(FactoryGirl.build(:section_step),
                                           User.new)
      n.strategy.should be_instance_of(Navigation::SectionStepStrategy)
    end
    it "raises an exception for unspported context objects" do
      expect{Navigation::ProgramNavigator.new(double(:foo), User.new)}
        .to raise_error(Navigation::UnsupportedContextObject)
    end
  end

  describe "navigation" do
    let(:nav) {Navigation::ProgramNavigator.new(FactoryGirl.build(:phase),
                                                User.new)}

    it "delegates #next to strategy" do
      n = double(:next)
      nav.strategy.should_receive(:next).and_return n
      nav.next.should == n
    end
    it "delegates #previous to strategy" do
      p = double(:previous)
      nav.strategy.should_receive(:previous).and_return p
      nav.previous.should == p
    end
  end

end
