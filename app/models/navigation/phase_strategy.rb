class Navigation::PhaseStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(phase)
    @phase = phase
    @program = phase.program
  end

  def next
    if section = @phase.sections.rank(:row_order).first
      full_section_path(section)
    elsif next_phase = @phase.next_phase
      full_phase_path(next_phase)
    else
      nil
    end
  end

  def previous
    full_phase_path(@phase)
  end
end
