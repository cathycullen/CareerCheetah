require 'spec_helper'

describe SectionStep do
  it{ should belong_to(:section)}

  describe "prev/next" do
    before do
      @section = FactoryGirl.create(:section)

      @first_step = FactoryGirl.build(:section_step)
      @second_step = FactoryGirl.build(:section_step)

      @section.section_steps << @first_step
      @section.section_steps << @second_step
    end

    describe "#next_step" do
      it "returns the next section step in order" do
        @first_step.next_step.should == @second_step
      end
    end

    describe "#previous_step" do
      it "returns the next section step in order" do
        @second_step.previous_step.should == @first_step
      end
    end
  end
end
