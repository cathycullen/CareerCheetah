class SessionsController < ApplicationController
  skip_before_filter :require_authentication, :only => [:new, :create]

  layout "login"

  def new
    redirect_to post_login_path if current_user
  end

  def create
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to post_login_path
    else
      flash.now[:error] = "Incorrect email address or password"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  private

  def post_login_path
    phase = current_program.phases.rank(:row_order).first
    program_phase_path(phase.program, phase)
  end

end
