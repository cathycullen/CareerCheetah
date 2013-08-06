class ProgramPhaseMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :phase
  belongs_to :program

  validates_presence_of :phase_id, :program_id

  ranks :row_order, :with_same => :program_id
end
