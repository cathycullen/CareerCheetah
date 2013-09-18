class UserFactorsController < ApplicationController
  def update
    @factor = current_user.user_factors.find(params[:id])

    @factor.name = params[:name]
    if @factor.save!
      render json: @factor
    else
      render json: {message: "Unable to save user factor"}, status: 400
    end
  end
end
