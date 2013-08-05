class RenameProgramPhase < ActiveRecord::Migration
  def change
    rename_table :program_phases, :program_phase_mappings
  end
end
