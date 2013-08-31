class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @user.user_careers.destroy_all

    cp = CareerPredictor.new
    cp.predict_careers(@user)
    @user.reload

    #@careers = current_user.user_careers.order("weight DESC")
  end

end
