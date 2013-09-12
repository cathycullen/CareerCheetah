class Navigation::SectionStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(section, user)
    @section = section
    @phase = @section.phase
    @program = @phase.program
    @user = user
  end

  def next
    if step = @section.section_steps.rank(:row_order).where("type != 'ConclusionStep'").first
      full_step_path(step)
    elsif @section.slug == "on-the-prowl"
      factors = @user.cheetah_factor_rankings.order("created_at ASC")
      if factors.empty?
        full_step_path(@section.section_steps.last)
      else
        program_phase_section_cheetah_factor_ranking_path(@program,
                                                          @phase,
                                                          @section,
                                                          factors.first)
      end
    elsif next_section = @section.next_section
      full_section_path(next_section)
    end
  end

  def previous
    if previous_section = @section.previous_section
      if SHOW_USER_CAREERS && previous_section.slug == "hunting-solo"
        program_phase_section_user_careers_path(@program, @phase, @section)
      elsif previous_section.section_steps.present?
        full_step_path(previous_section.section_steps.rank(:row_order).last)
      else
        full_section_path(previous_section)
      end
    else
      full_phase_path(@section.phase)
    end
  end
end
