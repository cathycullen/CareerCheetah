class QuestionsController < ApplicationController
  def show
    load_models
  end

  private

  def load_models
    @question = Question.find(params[:id])
    @section = Section.find_by(:slug => params[:section_id])
    @phase = Phase.find_by(:slug => params[:phase_id])
    @program = Program.find_by(:slug => params[:program_id])
  end
end
