class Navigation::QuestionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(question)
    @question = question
    @section = @question.section
    @phase = @section.phase
    @program = @phase.program
  end

  def next
    if next_question = @question.next_question
      full_question_path(next_question)
    elsif @section.completion_code
      full_section_conclusion_path(@section)
    elsif next_section = @section.next_section
      full_section_path(next_section)
    elsif next_phase = @phase.next_phase
      full_phase_path(next_phase)
    else
      nil
    end
  end

  def previous
    if previous_question = @question.previous_question
      full_question_path(previous_question)
    else
      full_section_path(@question.section)
    end
  end
end
