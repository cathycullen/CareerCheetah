class Navigation::SectionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(section, user)
    @section = section
    @phase = @section.phase
    @program = @phase.program
    @user = user
  end

  def next
    if question = @section.questions.rank(:row_order).first
      full_question_path(question)
    elsif @section.slug == "on-the-prowl"
      selections = RateableResponses.new(@user).response_option_selections
      program_phase_section_factor_rating_path(@program, @phase, @section, selections.first)
    else
      full_section_conclusion_path(@section)
    end
  end

  def previous
    if previous_section = @section.previous_section
      full_section_conclusion_path(previous_section)
    else
      full_phase_path(@section.phase)
    end
  end
end
