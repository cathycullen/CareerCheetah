class ProgramNavigationsController < ApplicationController

  before_filter :load_context_object
  # before_filter :verify_completion_code, :only => :next

  def next
    n = Navigation::ProgramNavigator.new(@context_object)
    redirect_to n.next
  end

  def previous
    n = Navigation::ProgramNavigator.new(@context_object)
    redirect_to n.previous
  end

  private
  def load_context_object
    if params[:question_id]
      @context_object = Question.find(params[:question_id])
    elsif params[:section_id]
      @context_object = Section.find_by(:slug => params[:section_id])
    elsif params[:section_conclusion_id]
      @context_object = SectionConclusion.new(Section.find_by(:slug => params[:section_conclusion_id]))
    elsif params[:phase_id]
      @context_object = Phase.find_by(:slug => params[:phase_id])
    end
  end

  def verify_completion_code
    if @context_object.instance_of?(SectionConclusion)
      if @context_object.section.completion_code != params[:completion_code]
        redirect_to :back
      end
    end
  end

end
