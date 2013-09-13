class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @user.career_suggestions.destroy_all

    cp = CareerPredictor.new
    cp.predict_careers(@user)
    @user.reload
  end
end
