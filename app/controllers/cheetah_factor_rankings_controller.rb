class CheetahFactorRankingsController < ApplicationController
  helper FactorRating
  layout "quiz"

  def show
    @program = Program.find_by(slug: params[:program_id])
    @section = Section.find_by(slug: params[:section_id])

    @cheetah_factor = CheetahFactor.find(params[:id])
    @response_option = @cheetah_factor.response_option
    @cheetah_factor_ranking = current_user.cheetah_factor_rankings.find_by(cheetah_factor_id: @cheetah_factor.id)

    # selections is always ordered by created_at
    user_factors = current_user.non_custom_cheetah_factors

    current_index = user_factors.index(@cheetah_factor)
    @next_selection = user_factors[current_index+1] if current_index < user_factors.length-1
    @previous_selection = user_factors[current_index-1] if current_index > 0
    @percent_complete = (( current_index+1).to_f / user_factors.count) * 100 -1
  end

  def create
    @cheetah_factor = CheetahFactor.find(params[:id])
    @cheetah_factor_ranking = current_user.cheetah_factor_rankings.find_by(cheetah_factor_id: @cheetah_factor.id)

    if params[:repeat] == "true"
      @cheetah_factor_ranking.final_rating = params[:rating]
    else
      @cheetah_factor_ranking.original_rating = params[:rating]
    end

    if @cheetah_factor_ranking.save
      render json: @cheetah_factor_ranking
    else
      render json: {message: "Unable to save rating"}
    end
  end

end
