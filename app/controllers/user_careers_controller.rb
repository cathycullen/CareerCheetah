class UserCareersController < ApplicationController

  def index
    current_user.user_careers.destroy_all

    cp = CareerPredictor.new()
    cp.predict_careers(current_user, 4)
    current_user.reload

   # @careers = current_user.careers
    @careers = current_user.user_careers

  end
end