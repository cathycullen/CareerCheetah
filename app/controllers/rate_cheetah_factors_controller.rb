class RateCheetahFactorsController < ApplicationController
  layout "quiz"

  def show
    @user_career = current_user.user_careers
                    .find(params[:user_career_id])
    @cheetah_factor = CheetahFactor.find(params[:id])
    @user_career_cheetah_factor_ranking = UserCareerCheetahFactorRanking.find_or_initialize_by(user: current_user,
                                                                                 user_career: @user_career,
                                                                                 cheetah_factor: @cheetah_factor)
  end
end
