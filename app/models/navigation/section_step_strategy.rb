class Navigation::SectionStepStrategy
  include Rails.application.routes.url_helpers
  include Navigation::PathGeneration

  def initialize(step, user)
    @step = step
    @section = @step.section
    @phase = @section.phase
    @program = @phase.program
    @user = user
  end

  def next
    if next_step = @step.next_step
      full_step_path(next_step)
    elsif show_career_suggestions && @section.slug == "hunting-solo"
      career_suggestions_path(@section)
    elsif @section.slug == "rank-factors-per-career"
      career_rankings_path
    elsif next_section = @section.next_section
      full_section_path(@section.next_section)
    elsif next_phase = @section.phase.next_phase
      full_phase_path(next_phase)
    else
      :back
    end
  end

  def previous
    if @section.slug == "rank-factors-per-career"
      career = @user.rateable_user_careers.rank(:row_order).last
      factor = @user.rateable_cheetah_factors.rank(:row_order).last
      user_career_rate_cheetah_factor_path(career, factor, section_id: @section.to_param, repeat: true)
    elsif previous_step = @step.previous_step
      full_step_path(previous_step)
    elsif @section.slug == "on-the-prowl" || @section.slug == "on-the-prowl-again"
      full_last_factor_rating_path(@program, @phase, @section, @user)
    else
      full_section_path(@section)
    end
  end
end
