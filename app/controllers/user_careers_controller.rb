class UserCareersController < ApplicationController
  def update
    @career = current_user.user_careers.find(params[:id])
    @career.name = params[:name]

    status = nil
    if params[:name].empty?
      status = @career.destroy
    else
      status = @career.save
    end

    if status
      render json: @career
    else
      render json: {message: "Unable to save user career"}, status: 400
    end
  end
end
