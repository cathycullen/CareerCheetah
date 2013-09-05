module Navigation
  class ProgramNavigator
    attr_reader :strategy
    delegate :next, :to => :strategy
    delegate :previous, :to => :strategy

    def initialize(context_object, user)
      klass = nil
      if context_object.kind_of? Phase
        klass = Navigation::PhaseStrategy
      elsif context_object.kind_of? Section
        klass = Navigation::SectionStrategy
      elsif context_object.kind_of? SectionStep
        klass = Navigation::SectionStepStrategy
      else
        raise UnsupportedContextObject.new("Unsupported context object: #{context_object.class.name}")
      end

      @strategy = klass.new(context_object, user)
    end
  end

  class UnsupportedContextObject < Exception; end
end
