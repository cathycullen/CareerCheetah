module QuestionHelper
  def option_checkbox(option)
    check_box_tag "response-options[]",
                  option.id,
                  response_cache.response_for(option),
                  {"data-response-option-selection-id" => "#{response_cache.response_for(option)}"}
  end

  def option_radio_button(option)
    radio_button_tag "response-options[]",
                     option.id,
                     response_cache.response_for(option),
                     {"data-response-option-selection-id" => "#{response_cache.response_for(option)}"}
  end

  def response_cache
    @response_cache ||= UserResponseCache.new(current_user, @question)
  end
end
