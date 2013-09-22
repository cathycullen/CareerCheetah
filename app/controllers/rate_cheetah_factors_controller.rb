class RateCheetahFactorsController < ApplicationController
  include Navigation::PathGeneration
  layout "quiz"
  before_filter :ensure_passion_factor_ranking_exists

  def show
    @user_career = current_user.rateable_user_careers
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
    @user_career = current_user.rateable_user_careers
                    .find(params[:user_career_id])

    next_factor = current_user.cheetah_factors.rank(:row_order).first
    @next = user_career_rate_cheetah_factor_path(@user_career, next_factor, section_id: params[:section_id], repeat: params[:repeat])

    career = current_user.rateable_user_careers.rank(:row_order).where(["row_order < ?", @user_career.row_order]).last
    if career
      @previous = user_career_rate_cheetah_factor_path(career, current_user.cheetah_factors.rank(:row_order).last, section_id: params[:section_id], repeat: params[:repeat])
    elsif params[:repeat] == "true"
      section = Section.find_by(slug: params[:section_id])
      @previous = full_step_path(section.section_steps.rank(:row_order).first)
    else
      section = Section.find_by(slug: params[:section_id])
      @previous = program_phase_section_path(section.phase.program,
                                             section.phase,
                                             section)
    end
  end

  private

  def next_path
    if next_factor = current_user.cheetah_factors.rank(:row_order).where(["row_order > ?", @cheetah_factor.row_order]).first
      user_career_rate_cheetah_factor_path(@user_career, next_factor, section_id: params[:section_id], repeat: params[:repeat])
    elsif career = current_user.rateable_user_careers.rank(:row_order).where(["row_order > ?", @user_career.row_order]).first
      user_career_rate_cheetah_factors_path(career, section_id: params[:section_id], repeat: params[:repeat])
    elsif params[:repeat] != "true"
      section = Section.find_by(slug: params[:section_id])
      full_step_path(section.section_steps.rank(:row_order).first)

      #user_career_rate_cheetah_factors_path(current_user.rateable_user_careers.first, section_id: params[:section_id], repeat: true)
    else
      section = Section.find_by(slug: params[:section_id])
      full_step_path(section.section_steps.last)
    end
  end

  def previous_path
    if previous_factor = current_user.cheetah_factors.rank(:row_order).where(["row_order < ?", @cheetah_factor.row_order]).last
      user_career_rate_cheetah_factor_path(@user_career, previous_factor, section_id: params[:section_id], repeat: params[:repeat])
    else
      user_career_rate_cheetah_factors_path(@user_career, section_id: params[:section_id], repeat: params[:repeat])
    end
  end

  def ensure_passion_factor_ranking_exists
    current_user.add_passion_cheetah_factor_ranking
  end
end
