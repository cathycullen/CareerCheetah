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
    @previous = previous_path


    total_factors = current_user.cheetah_factors.count
    current_index = current_user.cheetah_factors.rank(:row_order).to_a.index(@cheetah_factor) + 1
    @percent_complete = (current_index.to_f / total_factors) * 100
  end

  def index
    @user_career = current_user.user_careers
                    .find(params[:user_career_id])

    next_factor = current_user.cheetah_factors.rank(:row_order).first
    @next = user_career_rate_cheetah_factor_path(@user_career, next_factor)

    career = current_user.user_careers.rank(:row_order).where(["row_order < ?", @user_career.row_order]).last
    @previous = user_career_rate_cheetah_factor_path(career, current_user.cheetah_factors.rank(:row_order).last)
  end

  def next_path
    if next_factor = current_user.cheetah_factors.rank(:row_order).where(["row_order > ?", @cheetah_factor.row_order]).first
      user_career_rate_cheetah_factor_path(@user_career, next_factor)
    elsif career = current_user.user_careers.rank(:row_order).where(["row_order > ?", @user_career.row_order]).first
      user_career_rate_cheetah_factors_path(career)
    else
      :back
    end
  end

  def previous_path
    if previous_factor = current_user.cheetah_factors.rank(:row_order).where(["row_order < ?", @cheetah_factor.row_order]).last
      user_career_rate_cheetah_factor_path(@user_career, previous_factor)
    elsif career = current_user.user_careers.rank(:row_order).where(["row_order < ?", @user_career.row_order]).last
      user_career_rate_cheetah_factors_path(career)
    else
      :back
    end
  end
end
