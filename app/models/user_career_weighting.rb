class UserCareerWeighting
  def weight(user)
    weighted_careers = []
    user.user_careers.all.each do |career|
      total_weight = 0
      if(career.name != nil)
        career_ranking = UserCareerCheetahFactorRanking.where(:user_career => career)
        career_ranking.each do |career_rank|
          factor_rank = user.cheetah_factor_rankings.find_by(:cheetah_factor => career_rank.cheetah_factor)
          total_weight += (factor_rank.final_rating || 1) * (career_rank.final_rating || 1)
        end
        career.update_attribute(:total_weight, total_weight)
        weighted_careers <<  {:career_id => career.id, :weight => total_weight}
        puts "Career #{career.name}   weight: #{total_weight}"
      end
    end

    sorted_careers = weighted_careers.sort_by do |c|
     c[:weight]
    end.reverse
  end

end
