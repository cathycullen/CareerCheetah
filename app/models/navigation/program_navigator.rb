class Navigation::ProgramNavigator

  def initialize(context_object, user)
    if context_object.kind_of? Phase
      @s = Navigation::PhaseStrategy.new(context_object, user)
    elsif context_object.kind_of? Section
      @s = Navigation::SectionStrategy.new(context_object, user)
    elsif context_object.kind_of? SectionStep
      @s = Navigation::SectionStepStrategy.new(context_object, user)
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
