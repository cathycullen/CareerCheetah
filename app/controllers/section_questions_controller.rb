class SectionQuestionsController < ApplicationController
  def show
    @section_question = SectionQuestionMapping.find(params[:id])
    @question = @section_question.question
    @section = @section_question.section

    @phase = Phase.find_by(:slug => params[:phase_id])
    @program = Program.find_by(:slug => params[:program_id])
  end
end
