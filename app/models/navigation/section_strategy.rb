class Navigation::SectionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(section)
    @section = section
    @phase = @section.phase
    @program = @phase.program
  end

  def next
    if question = @section.questions.rank(:row_order).first
      full_question_path(question)
    elsif next_section = @section.next_section
      full_section_path(next_section)
    elsif next_phase = @section.phase.next_phase
      full_phase_path(next_phase)
    else
      nil
    end
  end

  def previous
    if previous_section = @section.previous_section
      if previous_section_question = previous_section.questions.rank(:row_order).last
        full_question_path(previous_section_question)
      else
        full_section_path(previous_section)
      end
    else
      full_phase_path(@section.phase)
    end
  end
end
