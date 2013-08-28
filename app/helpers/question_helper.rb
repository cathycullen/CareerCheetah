module QuestionHelper
  def option_checkbox(option)
    question = option.question
    check_box_tag "response-options[]",
                  option.id,
                  response_cache(question).response_for(option),
                  {"data-response-option-selection-id" => "#{response_cache(question).response_for(option)}"}
  end

  def option_radio_button(option)
    question = option.question
    radio_button_tag "response-options[]",
                     option.id,
                     response_cache(question).response_for(option),
                     {"data-response-option-selection-id" => "#{response_cache(question).response_for(option)}"}
  end

  def option_text_area(option)
    question = option.question
    value = nil
    if response_selection = response_cache(question).response_for(option)
      value = ResponseOptionSelection.find(response_selection).data[:value]
    end

    text_area_tag :response,
                  value,
                  :class => "full-textarea",
                  "data-response-option-id" => option.id
  end

  def response_cache(question)
    @response_cache ||= UserResponseCache.new(current_user, question)
  end

  # break response options into slices by group_size of either 4,8,12,16 depending upon length of response
  def option_groups(question)
    group_size = responses_per_page(question)

    question.response_options.rank(:row_order)
      .each_slice(group_size).to_a
  end

  def responses_per_page(question)
     max_length = question.response_options.map do |o|
      o.description.length
    end.max

    group_size = 4
    if max_length <= 15
      group_size = option_row_count*4
    elsif max_length <= 28
      group_size = option_row_count*3
    elsif max_length <= 38
      group_size = option_row_count*2
    end
    group_size
  end

  def option_row_count
    4
  end

end
