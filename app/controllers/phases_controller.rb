class PhasesController < ApplicationController
  layout "quiz"

  def show
    load_models
  end

  private

  def load_models
    @phase = Phase.find_by(:slug => params[:id])
    @program = Program.find_by(:slug => params[:program_id])
    @percent_complete = 0
  end
end
