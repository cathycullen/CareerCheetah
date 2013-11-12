class ProgramsController < ApplicationController
  def show
    program = Program.find_by(slug: params[:id])

    redirect_to program_phase_path(program,
                                   program.phases.rank(:row_order).first)
  end
end
