class UserCareerWeighting 
  def weight(user)
    weighted_careers = []
    user.user_careers.all.each do |career|
      total_weight = 0
      career_ranking = UserCareerCheetahFactorRanking.where(:user_career => career)
      career_ranking.each do |career_rank|
        factor_rank = user.cheetah_factor_rankings.find_by(:cheetah_factor => career_rank.cheetah_factor)
        total_weight += factor_rank.final_rating * career_rank.final_rating
        career.update_attribute(:total_weight, total_weight)

      end
      weighted_careers <<  {:career_id => career.id, :weight => total_weight}
    end

    sorted_careers = weighted_careers.sort_by do |c|
     c[:weight]
    end.reverse
  end

end
