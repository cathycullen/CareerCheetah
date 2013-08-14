class Navigation::SectionStepStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(step, user)
    @step = step
    @section = @step.section
    @phase = @section.phase
    @program = @phase.program
    @user = user
  end

  def next
    if next_step = @step.next_step
      full_step_path(next_step)
    elsif next_section = @section.next_section
      full_section_path(@section.next_section)
    elsif @phase == @program.phases.rank(:row_order).first
      user_careers_path
    elsif next_phase = @section.phase.next_phase
      full_phase_path(next_phase)
    else
      nil
    end
  end

  def previous
    if previous_step = @step.previous_step
      full_step_path(previous_step)
    elsif @section.slug == "on-the-prowl"
      selections = RateableResponses.new(@user).response_option_selections
      program_phase_section_factor_rating_path(@program, @phase, @section, selections.last)
    else
      full_section_path(@section)
    end
  end
end
