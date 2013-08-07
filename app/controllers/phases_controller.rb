class PhasesController < ApplicationController
  def show
    load_models
  end

  private

  def load_models
    @phase = Phase.find_by(:slug => params[:id])
    @program = Program.find_by(:slug => params[:program_id])
  end
end
