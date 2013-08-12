class Navigation::SectionConclusionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(section)
    @section = section
    @phase = @section.phase
    @program = @phase.program
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
    else
      full_section_path(@section)
    end
  end
end
