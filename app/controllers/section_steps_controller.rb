class SectionStepsController < ApplicationController
  layout "quiz"

  def show
    load_models
  end

  private

  def load_models
    @section_step = SectionStep.find(params[:id])
    @section = Section.find_by(:slug => params[:section_id])
    @phase = Phase.find_by(:slug => params[:phase_id])
    @program = Program.find_by(:slug => params[:program_id])
    @steps = @section.section_steps.rank(:row_order).to_a

    @percent_complete = ((@steps.index(@section_step)+1).to_f / @steps.count) * 100
  end

end
