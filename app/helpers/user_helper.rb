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
    mood_sum = []
    moods = ['positive', 'negative', 'neutral']
    mood_color = ['Green', 'Gray', 'Orange']
    
    i = 0
    moods.each do  |mood|
      mood_count = 0
      @user.response_option_selections.each do |ros|
        mood_count += ResponseOption.where(:id => ros.response_option_id).where(:response_type => mood).size
      end

      #puts "Mood Count for #{mood} is : #{mood_count}"
      mood_sum <<  { :mood => mood, :count => mood_count, :color => mood_color[i]}
      i = i + 1
    end

    @positive_mood_count = @negative_mood_count = neutral_mood_count = 0
    max = mood_sum.max_by{ |f| f[:count]}[:count]
    mood_sum.each do |f|
      f[:percent] = f[:count].to_f / max
      if f[:mood] == 'positive' then
        @positive_mood_count = f[:count]
      end
       if f[:mood] == 'negative' then
        @negative_mood_count = f[:count]
      end
       if f[:mood] == 'neutral' then
        @neutral_mood_count = f[:count]
      end
    end

    # @todo  would rather have gone in to mood_sum and gotten the count for :positive :negative
    @mood_summary_headline = 'negative_mood_1'
    # check ratios of positive moods to negative moods to create headline text for response distribution page
    if (@positive_mood_count.to_f / 3) >= @negative_mood_count.to_f 
      @mood_summary_headline = 'positive_mood_1'
        elsif @positive_mood_count > @negative_mood_count 
        @mood_summary_headline = 'positive_mood_2'
      elsif  (@negative_mood_count.to_f / 5) >= @positive_mood_count.to_f 
        @mood_summary_headline = 'negative_mood_2'
    end

  mood_sum
  end
end
