class UserCareerCheetahFactorRankingsController < ApplicationController
  def create
    if params[:id].present?
      ranking = UserCareerCheetahFactorRanking.find(params[:id])
    else
      career = UserCareer.find(params[:user_career_id])
      factor = CheetahFactor.find(params[:cheetah_factor_id])
      ranking = UserCareerCheetahFactorRanking.new(user: current_user,
                                                   user_career: career,
                                                   cheetah_factor: factor)
    end

    if params[:repeat]
      ranking.final_rating = params[:rating]
    else
      ranking.original_rating = params[:rating]
    end

    if ranking.save
      render json: ranking
    else
      render json: {message: "Error saving ranking"}, status: 400
    end

  end
end
