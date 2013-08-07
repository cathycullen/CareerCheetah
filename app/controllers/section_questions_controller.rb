class SectionQuestionsController < ApplicationController
  def show
    load_models
  end

  def next
    load_models
    if next_section_question = @section_question.next
      redirect_to program_phase_section_section_question_mapping_path(@program, @phase, @section, next_section_question)
    else
      redirect_to :back
    end
  end

  def previous
    load_models
    if previous_section_question = @section_question.previous
      redirect_to program_phase_section_section_question_mapping_path(@program, @phase, @section, previous_section_question)
    else
      redirect_to :back
    end
  end

  private

  def load_models
    @section_question = SectionQuestionMapping.find(params[:id])
    @question = @section_question.question
    @section = @section_question.section

    @phase = Phase.find_by(:slug => params[:phase_id])
    @program = Program.find_by(:slug => params[:program_id])
  end
end
