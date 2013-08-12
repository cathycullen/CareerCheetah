class Navigation::ProgramNavigator

  def initialize(context_object)
    case context_object.class.name
    when "Phase"
      @s = Navigation::PhaseStrategy.new(context_object)
    when "Section"
      @s = Navigation::SectionStrategy.new(context_object)
    when "SectionConclusion"
      @s = Navigation::SectionConclusionStrategy.new(context_object.section)
    when "Question"
      @s = Navigation::QuestionStrategy.new(context_object)
    else
      raise "Unsupported context object: #{context_object.class.name}"
    end
  end

  def next
    @s.next
  end

  def previous
    @s.previous
  end

end
