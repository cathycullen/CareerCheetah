class Navigation::ProgramNavigator

  def initialize(context_object)
    case context_object.class.to_s
    when "Phase"
      @s = Navigation::PhaseStrategy.new(context_object)
    when "Section"
      @s = Navigation::SectionStrategy.new(context_object)
    when "Question"
      @s = Navigation::QuestionStrategy.new(context_object)
    end
  end

  def next
    @s.next
  end

  def previous
    @s.previous
  end

end
