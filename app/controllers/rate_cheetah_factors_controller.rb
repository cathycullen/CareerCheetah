class RateCheetahFactorsController < ApplicationController
  layout "quiz"

  def show
    @user_career = current_user.user_careers
                    .find(params[:user_career_id])
    @cheetah_factor = CheetahFactor.find(params[:id])
    @user_career_cheetah_factor_ranking = UserCareerCheetahFactorRanking.find_or_initialize_by(user: current_user,
                                                                                 user_career: @user_career,
                                                                                 cheetah_factor: @cheetah_factor)
    @next = next_path
  end

  def next_path
    next_factor = current_user.cheetah_factors.rank(:row_order).where(["row_order > ?", @cheetah_factor.row_order]).first
    if next_factor
      user_career_rate_cheetah_factor_path(@user_career, next_factor)
    else
      career = current_user.user_careers.rank(:row_order).where(["row_order > ?", @user_career.row_order]).first
      factor = current_user.cheetah_factors.rank(:row_order).first
      user_career_rate_cheetah_factor_path(career, factor)
    end
  end

  def previous_path

  end
end
