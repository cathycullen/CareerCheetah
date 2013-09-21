class CheetahFactorsController < ApplicationController
  def update
    @factor = current_user.custom_cheetah_factors.find(params[:id])

    @factor.custom_name = params[:custom_name]
    if @factor.save!
      render json: @factor
    else
      render json: {message: "Unable to save custom factor"}, status: 400
    end
  end
end
