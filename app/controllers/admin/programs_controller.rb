class Admin::ProgramsController < ApplicationController
  def index
    @programs = Program.all
  end

  def show
    @program = Program.find_by(:slug => params[:id])
  end
end
