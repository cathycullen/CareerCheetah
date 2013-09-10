require 'spec_helper'

describe Navigation::SectionStepStrategy do
  describe "#next" do
    it "returns the path to the next step" do
      section = FactoryGirl.create(:section_with_steps)
      step = section.section_steps.rank(:row_order).first

      s = Navigation::SectionStepStrategy.new(step, User.new)
      path = double(:path)

      s.should_receive(:full_step_path)
        .with(step.next_step).and_return path
      s.next.should == path
    end

    context "when the current section is hunting-solo and no remaining steps" do
      before do
        @phase = FactoryGirl.create(:phase_with_sections)
        @section = @phase.sections.rank(:row_order).first
        @step = @section.section_steps.rank(:row_order).last
        @step.section.stub(:slug).and_return "hunting-solo"

        @s = Navigation::SectionStepStrategy.new(@step, User.new)
        @path = double(:path)
      end

      it "returns the user_careers path when careers are enabled" do
        @s.stub(:show_user_careers).and_return true

        @s.should_receive(:careers_path)
          .with(@section).and_return @path
        @s.next.should == @path
      end

      it "returns the next_section path when careers aren't enabled" do
        @s.stub(:show_user_careers).and_return false

        @s.should_receive(:full_section_path)
          .with(@section.next_section).and_return @path
        @s.next.should == @path
      end
    end
  end
end
