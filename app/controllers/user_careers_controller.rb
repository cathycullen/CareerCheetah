class UserCareersController < ApplicationController
  def update
    @career = current_user.user_careers.find(params[:id])

    @career.name = params[:name]
    if @career.save!
      render json: @career
    else
      render json: {message: "Unable to save user career"}, status: 400
    end
  end
end
