module QuestionHelper
  def option_checkbox(option)
    selection = current_user.response_option_selections.find_by(:response_option_id => option.id)
    check_box_tag "response-options[]", option.id, !selection.nil?, {"data-response-option-selection-id" => selection.try(:id)}
  end
end
