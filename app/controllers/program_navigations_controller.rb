class ProgramNavigationsController < ApplicationController
  include ProgramNavigationHelper

  def next
    load_models
    if @question
      if @question.next_question
        redirect_to full_question_path(@question.next_question)
      elsif @question.section.next_section
        redirect_to full_section_path(@question.section.next_section)
      end
    elsif @section
      redirect_to full_question_path(@section.questions.first)
    elsif @phase
      redirect_to full_section_path(@phase.sections.first)
    end
  end

  def previous
    load_models
    if @question
      if @question.previous_question
        redirect_to full_question_path(@question.previous_question)
      elsif @question.section.previous_section
        redirect_to full_section_path(@question.section.previous_section)
      end
    elsif @section && @section.previous_section
      redirect_to full_question_path(@section.previous_section.questions.last)
    elsif @phase && @phase.previous_phase
      redirect_to full_question_path(@phase.previous_phase.sections.last.questions.last)
    end
  end

  private
  def load_models
    @question = Question.find(params[:question_id]) if params[:question_id]
    @section = Section.find_by(:slug => params[:section_id]) if params[:section_id]
    @phase = Phase.find_by(:slug => params[:phase_id]) if params[:phase_id]
  end

end
