class PhasesController < ApplicationController
  layout "quiz"

  def show
    load_models
  end

  private

  def load_models
    @program = Program.find_by(:slug => params[:program_id])
    @phase = @program.phases.find_by(:slug => params[:id])
    @percent_complete = 0
  end
end
