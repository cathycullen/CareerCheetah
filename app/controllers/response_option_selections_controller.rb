class ResponseOptionSelectionsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @option = ResponseOption.find(params[:response_option_id])

    @selection = current_user.response_option_selections
                    .where(:response_option_id => @option.id)
                    .first_or_create!

    if @option.factor
      @factor = current_user.factor_selections
                  .where(:factor_id => @option.factor.id)
                  .first_or_create!
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
end
