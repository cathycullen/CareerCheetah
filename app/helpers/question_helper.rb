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

  def response_cache(question)
    @response_cache ||= UserResponseCache.new(current_user, question)
  end

  def option_groups(question)
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

    question.response_options.rank(:row_order)
      .each_slice(group_size).to_a
  end

  def option_row_count
    4
  end

end
