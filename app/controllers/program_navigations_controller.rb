class ProgramNavigationsController < ApplicationController

  def next
    load_models
    context_object = nil

    if params[:question_id]
      context_object = @question
    elsif params[:section_id]
      context_object = @section
    elsif params[:phase_id]
      context_object = @phase
    end

    n = Navigation::ProgramNavigator.new(context_object)
    redirect_to n.next
  end

  def previous
    load_models
    context_object = nil

    if params[:question_id]
      context_object = @question
    elsif params[:section_id]
      context_object = @section
    elsif params[:phase_id]
      context_object = @phase
    end

    n = Navigation::ProgramNavigator.new(context_object)
    redirect_to n.previous
  end

#    if @question
#      if @question.previous_question
#        redirect_to full_question_path(@question.previous_question)
#      elsif @question.section.previous_section
#        redirect_to full_question_path(@question.section.previous_section.questions.last)
#      else
#        redirect_to full_section_path(@question.section)
#      end
#    elsif @section && @section.previous_section
#      redirect_to full_question_path(@section.previous_section.questions.last)
#    elsif @phase && @phase.previous_phase
#      redirect_to full_question_path(@phase.previous_phase.sections.last.questions.last)
#    end
#  end

  private
  def load_models
    @question = Question.find(params[:question_id]) if params[:question_id]
    @section = Section.find_by(:slug => params[:section_id]) if params[:section_id]
    @phase = Phase.find_by(:slug => params[:phase_id]) if params[:phase_id]
  end

end
