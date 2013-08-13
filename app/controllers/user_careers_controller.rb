class UserCareersController < ApplicationController

  def index
    current_user.user_careers.destroy_all

    cp = CareerPredictor.new()
    job_zone = 4
    cp.predict_careers(current_user, job_zone)
    current_user.reload

    @careers = current_user.user_careers.order("weight DESC")
  end
end
