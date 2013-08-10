class UserResponseCache
  def initialize(user, question)
    responses = user.response_option_selections
                  .where(:response_option_id => question.response_options.pluck(:id)).select([:id, :response_option_id])
    @map = {}
    responses.each do |r|
      @map[r.response_option_id] = r.id
    end
  end

  def response_for(response_option)
    @map[response_option.id]
  end
end
