class RateableResponses
  SECTION_NAMES = ["Environment", "Engagement", "People", "Activities", "Pay, Perks, Prep"]

  def initialize(user)
    @user = user
    @selected_response_options = user.response_options.to_a
  end

  def sections
    @sections ||= SECTION_NAMES.map{|n| Section.find_by(name: n)}
  end

  def response_option_selections
    @selected_responses ||= begin
      @user.response_option_selections.order("created_at ASC").select do |s|
        s.response_option && s.response_option.rating_prompt && sections.include?(s.response_option.question.question_step.section)
      end
    end
  end
end
