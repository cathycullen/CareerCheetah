class ProgramNavigationsController < ApplicationController
  before_filter :load_context_object

  def next
    n = Navigation::ProgramNavigator.new(@context_object, current_user)
    redirect_to n.next
  end

  def previous
    n = Navigation::ProgramNavigator.new(@context_object, current_user)
    redirect_to n.previous
  end

  private
  def load_context_object
    if params[:section_step_id]
      @context_object = SectionStep.find(params[:section_step_id])
    elsif params[:section_id]
      @context_object = Section.find(params[:section_id])
    elsif params[:phase_id]
      @context_object = Phase.find(params[:phase_id])
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
