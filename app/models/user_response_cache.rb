class UserResponseCache
  def initialize(user, question)
    #get response_options id's for response_options_selections
    responses = user.response_option_selections
                  .where(:response_option_id => question.response_options.pluck(:id)).select([:id, :response_option_id])
    @map = {}
    responses.each do |r|
      @map[r.response_option_id] = r.id
    end
  end

  # return this users selections for this response_option
  def response_for(response_option)
    @map[response_option.id]
  end
end
