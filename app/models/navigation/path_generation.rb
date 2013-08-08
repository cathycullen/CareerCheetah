module Navigation::PathGeneration
  def full_question_path(question)
    section = question.section
    phase = section.phase
    program = phase.program

    program_phase_section_question_path(program,
                                        phase,
                                        section,
                                        question)
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
end
