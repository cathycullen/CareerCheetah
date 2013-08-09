class ProgramNavigationsController < ApplicationController

  def next
    load_context_object
    n = Navigation::ProgramNavigator.new(@context_object)

    redirect_to n.next
  end

  def previous
    load_context_object
    n = Navigation::ProgramNavigator.new(@context_object)

    redirect_to n.previous
  end

  private
  def load_context_object
    if params[:question_id]
      @context_object = Question.find(params[:question_id])
    elsif params[:section_id]
      @context_object = Section.find_by(:slug => params[:section_id])
    elsif params[:phase_id]
      @context_object = Phase.find_by(:slug => params[:phase_id])
    end
  end

end
