class Navigation::SectionConclusionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(section, user)
    @section = section
    @phase = @section.phase
    @program = @phase.program
    @user = user
  end

  def next
    if next_section = @section.next_section
      full_section_path(next_section)
    # TODO This is a hacky. We need a better way to describe the flow from
    # one phase to another. Perhaps an attribute on when to trigger the
    # career prediction?
    elsif @phase == @program.phases.rank(:row_order).first
      user_careers_path
    elsif next_phase = @section.phase.next_phase
      full_phase_path(next_phase)
    else
      nil
    end
  end

  def previous
    if last_section_question = @section.questions.rank(:row_order).last
      full_question_path(last_section_question)
    # In an effort to avoid STI on the sections table, I'm letting this hack slide in for now
    elsif @section.slug == "on-the-prowl"
      selections = RateableResponses.new(@user).response_option_selections
      program_phase_section_factor_rating_path(@program, @phase, @section, selections.last)
    else
      full_section_path(@section)
    end
  end
end
