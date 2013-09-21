class CheetahFactorRankingsController < ApplicationController
  helper FactorRating
  layout "quiz"

  def show
    @program = Program.find_by(slug: params[:program_id])
    @section = Section.find_by(slug: params[:section_id])

    @cheetah_factor_ranking = CheetahFactorRanking.find(params[:id])
    @cheetah_factor = @cheetah_factor_ranking.cheetah_factor
    @response_option = @cheetah_factor.response_option

    # selections is always ordered by created_at
    user_factors = @user.cheetah_factor_rankings.order("created_at ASC")

    current_index = user_factors.index(@cheetah_factor_ranking)
    @next_selection = user_factors[current_index+1] if current_index < user_factors.length-1
    @previous_selection = user_factors[current_index-1] if current_index > 0
    @percent_complete = (( current_index+1).to_f / user_factors.count) * 100 -1
  end

  def create
    @cheetah_factor_ranking = CheetahFactorRanking.find(params[:id])

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


  private
  def cheetah_factors
    # the non-custom cheetah factors
    current_user.cheetah_factors.where("cheetah_factors.user_id IS NULL").order("cheetah_factors.created_at ASC")
  end
end
