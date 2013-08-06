class ProgramPhaseMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :phase
  belongs_to :program

  ranks :row_order, :with_same => :program_id
end
