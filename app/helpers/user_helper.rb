module UserHelper
  def best_work_fit

    # compute best work fit sums by categories for current_user
    # return hash table with categories and sums
    fit_codes_summary = []
    codes = ['Corporate', 'Freelance', 'Entrepreneur', 'Non-profit']
    codes.each do  |code|
      code_count = 0
      @user.response_option_selections.each do |response_option_selection|
        code_count += ResponseOption.where(:id => response_option_selection.response_option_id).where(:fit_code => code[0]).size
      end

      fit_codes_summary <<  {:fit_code => code, :count => code_count}
    end

    max = fit_codes_summary.max_by{ |f| f[:count]}[:count]
    fit_codes_summary.each do |f|
      f[:percent] = f[:count].to_f / max
    end

    fit_codes_summary
  end

  def fit_count_by_type(fit_code)
    # compute sum of fit_codes for this current_user and fit_code
    sum = 0
    @user.response_option_selections.each do |ros|
      sum += ResponseOption.where(:id => ros.response_option_id).where(:fit_code => fit_code).size
    end

    sum
  end

  def mood_summary
    mood_summary = []
    moods = ['positive', 'negative', 'neutral']
    mood_color = ['Green', 'Gray', 'Orange']
    

    i = 0
    moods.each do  |mood|
      mood_count = 0
      @user.response_option_selections.each do |ros|
        mood_count += ResponseOption.where(:id => ros.response_option_id).where(:response_type => mood).size
      end

      #puts "Mood Count for #{mood} is : #{mood_count}"
      mood_summary <<  { :mood => mood, :count => mood_count, :color => mood_color[i]}
      i = i + 1
    end

    max = mood_summary.max_by{ |f| f[:count]}[:count]
    mood_summary.each do |f|
      f[:percent] = f[:count].to_f / max
    end
  end


end
