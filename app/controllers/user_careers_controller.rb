class UserCareersController < ApplicationController
  layout "quiz"

  def index
    load_models
    current_user.user_careers.destroy_all

    cp = CareerPredictor.new()
    cp.predict_careers(current_user)
    current_user.reload

    @careers = current_user.user_careers.order("weight DESC")
  end

  private

  def load_models
    @section = Section.find_by(:slug => params[:section_id])
    @phase = Phase.find_by(:slug => params[:phase_id])
    @program = Program.find_by(:slug => params[:program_id])
    @steps = @section.section_steps.rank(:row_order).to_a
    @percent_complete = 99
  end
end
