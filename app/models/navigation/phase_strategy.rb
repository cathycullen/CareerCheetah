class Navigation::PhaseStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(phase)
    @phase = phase
    @program = phase.program
  end

  def next
    if section = @phase.sections.rank(:row_order).first
      full_section_path(section)
    elsif next_phase = @phase.next_phase
      full_phase_path(next_phase)
    else
      nil
    end
  end

  def previous
    if previous_phase = @phase.previous_phase
      if section = previous_phase.sections.rank(:row_order).last
        if question = section.questions.rank(:row_order).last
          full_question_path(question)
        else
          full_section_path(section)
        end
      else
        full_phase_path(previous_phase)
      end
    else
      full_phase_path(@phase)
    end
  end
end
