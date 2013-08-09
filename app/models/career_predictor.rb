
class CareerPredictor
  def predict_careers(user, job_zone)
     factors = user.factors

    # Find Careers that have a FactorMapping for the Factors a User has selected
    possible_careers = Career.where(:job_zone => job_zone).joins(:career_factor_mappings).where("career_factor_mappings.factor_id" =>  factors.map(&:id)).uniq

    # Build a Hash that maps a Career#id and sum of CareerFactor weights for those factors the user has selected
    weighted_careers = []
    possible_careers.each do |career|
      total_weight_for_user_factors = career.career_factor_mappings.where(:factor_id => factors.map(&:id)).sum(:weight)
      weighted_careers << {:career_id => career.id, :weight => total_weight_for_user_factors}
    end

    # Expected data structure for weighted_careers: [{:career_id => 1, :weight => 2.4}, {:career_id => 2, :weight => 0.7}, {:career_id => 32, :weight => 9.1}]
    sorted_careers = weighted_careers.sort_by do |c| 
      c[:weight]
    end.reverse
	
	# destroy old UserCareer results for this user
	user.user_careers.destroy_all
	
    #traverse sorted careers and print
    results = sorted_careers.map do |c|
#	  puts "#{Career.find(c[:career_id]).title} - #{c[:weight]}"
	  UserCareer.create!(:user_id => user.id, :career_id => c[:career_id], :weight => c[:weight])
    end
  end

  def run_predictor
    user = User.where(:name => "christine").first
    cp = CareerPredictor.new
    job_zone = 4
    cp.predict_careers(user, job_zone)
  end

  #check results
  def check_predictions
    user = User.where(:name => "christine").first
  
    user.user_careers.first(10).each do |uc| 
      career = Career.find(uc.career_id) 
#      puts "#{career.onet_code} #{career.title} weight: #{uc.weight}"
    end 
  end

end