class CareerRankingsController < ApplicationController
  layout "quiz"

  def index
    cw = UserCareerWeighting.new()
    @career_rankings = cw.weight(current_user)
    @percent_complete =99
  end

end
