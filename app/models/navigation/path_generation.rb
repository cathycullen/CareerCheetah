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
end
