class Navigation::QuestionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(question, user)
    @question = question
    @section = @question.section
    @phase = @section.phase
    @program = @phase.program
    @user = user
  end

  def next
    if next_question = @question.next_question
      full_question_path(next_question)
    else
      full_section_conclusion_path(@section)
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
