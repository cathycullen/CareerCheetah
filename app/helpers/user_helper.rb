module UserHelper

def best_work_fit
    response_options = SectionStep.where(:section_id => (Section.where(:name => "Determining Fit"))).where(:type => 'QuestionStep').first.question.response_options
    selections = current_user.response_option_selections.where(:response_option_id => response_options.map(&:id))

    fit_codes_summary = []
    codes = ['Corporate', 'Freelance', 'Entrepreneur', 'Non-profit']
    codes.each do  |code|
      code_count = 0
      selections.each do |response_option_selection|
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

  def negative_moods_selected
    response_options = ResponseOption.where(:response_type => 'negative')
    current_user.response_option_selections.where(:response_option_id => response_options.map(&:id)) + negative_thoughts_selected
  end

  def negative_thoughts_selected
    negative_thought_selections = []
    if section = Section.find_by(:slug => "moods")
      section.section_steps.where(:type => "QuestionStep").each do |s|
        options = s.question.response_options
        selections = current_user.response_option_selections.where(:response_option_id => options.map(&:id)).to_a
        negative_thought_selections += selections.select{ |s| s.data && s.data["negative"] == "true"}
      end
    end

    negative_thought_selections.flatten
  end

  def get_moods_selected_by_type(mood_type)
    response_options = ResponseOption.where(:response_type => mood_type)
    current_user.response_option_selections.where(:response_option_id => response_options.map(&:id))
  end

  def obstacles_selected
    obstalces_response_options = []
    response_options = SectionStep.where(:section_id => (Section.where(:name => "Obstacles"))).where(:type => 'QuestionStep').first.question.response_options
    current_user.response_option_selections.where(:response_option_id => response_options.map(&:id))
  end

  def values_selected
    response_options = SectionStep.where(:section_id => (Section.where(:name => "Values"))).where(:type => 'QuestionStep').first.question.response_options
    current_user.response_option_selections.where(:response_option_id => response_options.map(&:id))
  end

  def negative_moods_selections_selected
    selected_negative_thoughts = negative_thoughts_selected.select(&:selected)
    negative_thought_selections = []
    response_options = ResponseOption.where(:response_type => 'negative')
    all = current_user.response_option_selections.where(:selected => true).where(:response_option_id => response_options.map(&:id)) + selected_negative_thoughts

    all.first(3)
  end


  def value_selections_selected
    response_options = SectionStep.where(:section_id => (Section.where(:name => "Values"))).where(:type => 'QuestionStep').first.question.response_options
    current_user.response_option_selections.where(:selected => true).where(:response_option_id => response_options.map(&:id)).first(10)
  end

  def mood_summary
    # get selected moods
    mood_sum = []
    moods = ['positive', 'negative', 'neutral']
    mood_color = ['Green', 'Gray', 'Orange']

    #count moods by category    
    i = mood_count = total_mood_count = 0
    total_mood_count = positive_mood_count = negative_mood_count = neutral_mood_count = 0

    moods.each do  |mood|
      mood_count = 0
      if(selections = get_moods_selected_by_type(mood))
        puts "get_moods_selected_by_type(#{mood}  #{selections.count}"
        mood_count = selections.size
        total_mood_count += selections.size
        if mood == 'positive'
          positive_mood_count = mood_count
        elsif mood == 'negative'
          negative_mood_count = mood_count
        elsif mood == 'neutral'
          neutral_mood_count = mood_count
        end
      end

      #puts "Mood Count for #{mood} is : #{mood_count} total_mood_count #{total_mood_count}"
      mood_sum <<  { :mood => mood, :count => mood_count, :color => mood_color[i]}
      i = i + 1
    end

    mood_sum.each do |f|
      if f[:count] == 0
        f[:percent] = 0
      else
        f[:percent] = f[:count].to_f / total_mood_count
      end
    end
    # @todo  would rather have gone in to mood_sum and gotten the count for :positive :negative
    @mood_summary_headline = 'negative_mood_1'
    # check ratios of positive moods to negative moods to create headline text for response distribution page
    if positive_mood_count > 0 && negative_mood_count == 0
      @mood_summary_headline = 'positive_mood_3'
      elsif (positive_mood_count > 0 && (positive_mood_count.to_f / 3) >= negative_mood_count.to_f )
        @mood_summary_headline = 'positive_mood_1'
          elsif positive_mood_count > 0 && positive_mood_count > negative_mood_count 
        @mood_summary_headline = 'positive_mood_2'
      elsif  (negative_mood_count > 0 && (negative_mood_count.to_f / 5) >= positive_mood_count.to_f )
        @mood_summary_headline = 'negative_mood_2'
      elsif  (negative_mood_count == 0 &&  positive_mood_count == 0 && neutral_mood_count == 0)
        @mood_summary_headline = 'no_moods_chosen'
    end

  mood_sum
  end

  def factor_rating(user, factor)
    option = ResponseOption.find_by(:factor_id => factor.id)
    selection = user.response_option_selections.find_by(:response_option_id => option.id)
    selection.rating if selection
  end

  def ranked_factor_selections(user)
    user.factor_selections.sort_by do |factor_selection|
      factor_rating(@user, factor_selection.factor) || 0
    end.reverse
  end
end
