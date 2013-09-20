class ResponseOptionSelectionsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @option = ResponseOption.find(params[:response_option_id])

    # Single and boolean prompt questions can't have more than one recorded response.
    # Delete any that might be saved previously
    if @question.single? || @question.boolean?
      current_user.response_option_selections
        .where(:response_option_id => @question.response_options.pluck(:id))
        .destroy_all
    end

    @selection = current_user.response_option_selections
                    .where(:response_option_id => @option.id)
                    .first_or_create!

    if params[:data]
      @selection.data = params[:data].to_hash
      @selection.save!
    end

    # If this option maps to a Factor, record that this user 'has' that Factor
    if @option.factor
      @factor = current_user.factor_selections
                  .where(:factor_id => @option.factor.id)
                  .first_or_create!
    end

    # If this option maps to CheetahFactor (one they will rate later), record that this
    # user 'has' this CheetahFactor by creating a CheetahFactorRaking record. We don't have
    # a rating right now, but we save a placeholder record that we'll iterate over later when
    # a user does their rating.
    if @option.cheetah_factor &&
       CheetahFactorRanking.find_by(user: current_user, cheetah_factor: @option.cheetah_factor).nil?

      CheetahFactorRanking.create!(user: current_user,
                                  cheetah_factor: @option.cheetah_factor)
    end

    render :json => @selection
  end

  def destroy
    @selection = current_user.response_option_selections
                    .find_by(:id => params[:id])
    if @selection
      @selection.destroy
      if @selection.response_option.factor
        if selected_factor = current_user.factor_selections.find_by(:factor_id => @selection.response_option.factor.id)
          selected_factor.destroy
        end
      end
      render :json => @selection
    else
      render :json => {:message => "No change"}
    end
  end

  def update
    @selection = current_user.response_option_selections
                    .find_by(:id => params[:id])
    @selection.selected = params[:selected]
    @selection.save

    render :json => @selection
  end
end
