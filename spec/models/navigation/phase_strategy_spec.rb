require 'spec_helper'

describe Navigation::PhaseStrategy do

  describe "#next" do
    it "returns the first section's path" do
      phase = FactoryGirl.create(:phase_with_sections)
      s = Navigation::PhaseStrategy.new(phase, User.new)

      path = double(:path)
      s.should_receive(:full_section_path)
        .with(phase.sections.rank(:row_order).first).and_return path

      s.next.should == path
    end

    it "returns the next phase's path" do
      program = FactoryGirl.create(:program_with_multiple_empty_phases)
      phase = program.phases.rank(:row_order).first
      s = Navigation::PhaseStrategy.new(phase, User.new)

      path = double(:path)
      s.should_receive(:full_phase_path)
        .with(phase.next_phase).and_return path

      s.next.should == path
    end

    it "returns :back when no sections or phases are present" do
      phase = FactoryGirl.create(:phase)
      s = Navigation::PhaseStrategy.new(phase, User.new)

      s.next.should == :back
    end
  end

  describe "#previous" do
    it "returns the previous phase's last section's step's path" do
      program = FactoryGirl.create(:program_with_multiple_phases)
      phase = program.phases.rank(:row_order).last
      last_step = phase.previous_phase.sections.rank(:row_order).last
                   .section_steps.rank(:row_order).last
      s = Navigation::PhaseStrategy.new(phase, User.new)

      path = double(:path)
      s.should_receive(:full_step_path)
        .with(last_step).and_return path

      s.previous.should == path
    end

    it "returns the previous phase's last section's path" do
      program = FactoryGirl.create(:program_with_multiple_phases)
      phase = program.phases.rank(:row_order).last
      last_section = phase.previous_phase.sections.rank(:row_order).last
      last_section.section_steps.destroy_all

      s = Navigation::PhaseStrategy.new(phase, User.new)

      path = double(:path)
      s.should_receive(:full_section_path)
        .with(last_section).and_return path

      s.previous.should == path
    end

    it "returns the previous phase's path" do
      program = FactoryGirl.create(:program_with_multiple_empty_phases)
      phase = program.phases.rank(:row_order).last
      previous_phase = phase.previous_phase

      s = Navigation::PhaseStrategy.new(phase, User.new)

      path = double(:path)
      s.should_receive(:full_phase_path)
        .with(previous_phase).and_return path

      s.previous.should == path
    end

    it "returns :back when no previous sections or phases are present" do
      program = FactoryGirl.create(:program)
      program.phases << FactoryGirl.build(:phase)
      phase = program.phases.rank(:row_order).last

      s = Navigation::PhaseStrategy.new(phase, User.new)

      s.previous.should == :back
    end
  end
end
