class QuestionsController < ApplicationController
  layout "quiz"

  def show
    load_models
  end

  private

  def load_models
    @question = Question.find(params[:id])
    @section = Section.find_by(:slug => params[:section_id])
    @phase = Phase.find_by(:slug => params[:phase_id])
    @program = Program.find_by(:slug => params[:program_id])
    @questions_array = @section.questions.rank(:row_order).to_a
    @percent_complete = ((@questions_array.index(@question) +1).to_f / @questions_array.count) * 100
  end

end
