module Navigation::PathGeneration
  def full_step_path(step)
    section = step.section
    phase = section.phase
    program = phase.program

    program_phase_section_section_step_path(program,
                                            phase,
                                            section,
                                            step)
  end

  def full_section_path(section)
    phase = section.phase
    program = phase.program

    program_phase_section_path(program,
                               phase,
                               section)
  end

  def full_phase_path(phase)
    program_phase_path(phase.program, phase)
  end

  def career_suggestions_path(section)
    program_phase_section_career_suggestions_path(section.phase.program, section.phase, section)
  end

  def full_factor_rating_path(program, phase, section, user, custom=false)
    repeat = section.slug != "on-the-prowl"

    if custom
      factors = user.rateable_custom_cheetah_factors
    else
      factors = user.rateable_non_custom_cheetah_factors
    end

    if factors.empty?
      full_step_path(section.section_steps.last)
    else
      program_phase_section_cheetah_factor_ranking_path(program,
                                                        phase,
                                                        section,
                                                        factors.first,
                                                        :repeat => repeat,
                                                        :custom_factors => custom)
    end
  end

  def full_last_factor_rating_path(program, phase, section, user)
    repeat = section.slug != "on-the-prowl"

    factors = user.rateable_non_custom_cheetah_factors
    if factors.empty?
      full_section_path(@section)
    else
      program_phase_section_cheetah_factor_ranking_path(@program,
                                                        @phase,
                                                        @section,
                                                        factors.last,
                                                        repeat: repeat)
    end
  end
end
