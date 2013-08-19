class FactorRatingsController < ApplicationController
  helper FactorRating
  layout "quiz"

  def show
    @program = Program.find_by(slug: params[:program_id])
    @section = Section.find_by(slug: params[:section_id])

    @response_selection = ResponseOptionSelection.find(params[:id])
    @response_option = @response_selection.response_option

    # selections is always ordered by created_at
    selections = RateableResponses.new(current_user).response_option_selections
    current_index = selections.index(@response_selection)
    @next_selection = selections[current_index+1] if current_index < selections.length-1
    @previous_selection = selections[current_index-1] if current_index > 0
    @percent_complete = (( current_index+1).to_f / selections.count) * 100 -1
  end

  def create
    @response_selection = ResponseOptionSelection.find(params[:id])
    @response_selection.rating = params[:rating]
    if @response_selection.save
      render json: @response_selection
    else
      render json: {message: "Unable to save rating"}
    end
  end
end
