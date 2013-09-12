class UserCheetahFactorsController < ApplicationController
  helper FactorRating
  layout "quiz"

  def show
    @program = Program.find_by(slug: params[:program_id])
    @section = Section.find_by(slug: params[:section_id])

    @user_cheetah_factor = UserCheetahFactor.find(params[:id])
    @cheetah_factor = @user_cheetah_factor.cheetah_factor
    @response_option = @cheetah_factor.response_option

    # selections is always ordered by created_at
    user_factors = @user.user_cheetah_factors.order("created_at ASC")

    current_index = user_factors.index(@user_cheetah_factor)
    @next_selection = user_factors[current_index+1] if current_index < user_factors.length-1
    @previous_selection = user_factors[current_index-1] if current_index > 0
    @percent_complete = (( current_index+1).to_f / user_factors.count) * 100 -1
  end

  def create
    @user_cheetah_factor = UserCheetahFactor.find(params[:id])
    @user_cheetah_factor.original_rating = params[:rating]
    if @user_cheetah_factor.save
      render json: @user_cheetah_factor
    else
      render json: {message: "Unable to save rating"}
    end
  end
end
