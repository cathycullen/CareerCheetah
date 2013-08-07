class ProgramNavigationsController < ApplicationController

  def next
    load_models
    if @question && @question.next_question
      redirect_to program_phase_section_question_path(@question.program, @question.phase, @question.section, @question.next_question)
    else
      redirect_to :back
    end
  end

  def previous
    load_models
    if @question && @question.previous_question
      redirect_to program_phase_section_question_path(@question.program, @question.phase, @question.section, @question.previous_question)
    else
      redirect_to :back
    end
  end

  private
  def load_models
    @question = Question.find(params[:question_id]) if params[:question_id]
    @section = Section.find_by(:slug => params[:section_id]) if params[:section_id]
    @phase = Phase.find_by(:slug => params[:phase_id]) if params[:phase_id]
  end

end
