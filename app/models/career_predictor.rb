
class CareerPredictor
  def predict_careers(user)
     factors = user.factors
     work_zone = work_zone(user)

    # Find Careers that have a FactorMapping for the Factors a User has selected
    possible_careers = Career.where(:job_zone => work_zone).joins(:career_factor_mappings).where("career_factor_mappings.factor_id" =>  factors.map(&:id)).uniq

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

    # destroy old CareerSuggestion results for this user
    user.career_suggestions.destroy_all

    #traverse sorted careers and print
    results = sorted_careers.map do |c|
    #puts "#{Career.find(c[:career_id]).title} - #{c[:weight]}"
    CareerSuggestion.create!(:user_id => user.id, :career_id => c[:career_id], :weight => c[:weight])
    end
  end

  def work_zone(user)
    work_zone = 4   #default value

    # get response_options for work_zones
    response_options_for_work_zones = ResponseOption.where(:work_zone => ['1', '2', '3', '4', '5'] )

    #  get response_option_selections for this user for work_zones response_options
    work_zones_selected = user.response_option_selections.where(:response_option_id => response_options_for_work_zones.map(&:id))

    # in theory there should only be one work_zone selected so one liner could do it.     if work_zones_selected.size  then work_zone = work_zones_selected.first.response_option.work_zone.to_i
    work_zones = []
    work_zones_selected.each do |response_option_selection|
      response_option = response_option_selection.response_option
      work_zones << response_option.work_zone
    end
    if(!work_zones.empty?) then
      work_zone =  work_zones.sort.reverse[0].to_i
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

    user.career_suggestions.first(10).each do |uc|
      career = Career.find(uc.career_id)
#      puts "#{career.onet_code} #{career.title} weight: #{uc.weight}"
    end
  end

end
